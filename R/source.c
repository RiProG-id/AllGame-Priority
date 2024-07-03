#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <string.h>
#include <sys/types.h>

void setPriorities(const char *pid) {
    char cmd[512];
    FILE *pipe;

    snprintf(cmd, sizeof(cmd), "pgrep -f '%s'", pid);
    if ((pipe = popen(cmd, "r")) != NULL) {
        char pids[256];
        while (fgets(pids, sizeof(pids), pipe) != NULL) {
            pids[strcspn(pids, "\n")] = 0;
            snprintf(cmd, sizeof(cmd), "/proc/%s/task/", pids);
            DIR *task_dir = opendir(cmd);
            if (task_dir != NULL) {
                struct dirent *task_entry;
                while ((task_entry = readdir(task_dir)) != NULL) {
                    if (task_entry->d_type == DT_DIR && strcmp(task_entry->d_name, ".") != 0 && strcmp(task_entry->d_name, "..") != 0) {
                        snprintf(cmd, sizeof(cmd), "renice -n -20 -p %s", task_entry->d_name);
                        system(cmd);
                        snprintf(cmd, sizeof(cmd), "ionice -c 1 -n 0 -p %s", task_entry->d_name);
                        system(cmd);
                        snprintf(cmd, sizeof(cmd), "chrt -f -p 99 %s", task_entry->d_name);
                        system(cmd);
                    }
                }
                closedir(task_dir);
            }
        }
        pclose(pipe);
    }
}

void readGameList(char games[][128], int *count) {
    FILE *file = fopen("/data/adb/modules/Priority/gamelist.txt", "r");
    if (file == NULL) {
        exit(EXIT_FAILURE);
    }

    *count = 0;
    char line[128];
    while (fgets(line, sizeof(line), file) != NULL && *count < 128) {
        line[strcspn(line, "\n")] = '\0';
        if (strlen(line) == 0) {
            continue;
        }
        strncpy(games[*count], line, sizeof(games[*count]) - 1);
        games[*count][sizeof(games[*count]) - 1] = '\0';
        (*count)++;
    }

    fclose(file);
}

void showToast(const char *message) {
    char cmd[512];
    snprintf(cmd, sizeof(cmd), "am start -a android.intent.action.MAIN -e toasttext \"%s\" -n bellavita.toast/.MainActivity", message);
    system(cmd);
}

int main() {
  
    int null_fd = open("/dev/null", O_WRONLY);
    dup2(null_fd, STDOUT_FILENO);
    dup2(null_fd, STDERR_FILENO);
    close(null_fd);

    showToast("AllGame Priority: By RiProG");
    sleep(2);
    showToast("Program is running in the background.");

    char prev_window_state[10] = "";
    char game_running[10] = "";
    char games[128][128];
    int game_count;

    readGameList(games, &game_count);

    while (1) {
        system("clear");

        FILE *fp = popen("dumpsys window | grep -E 'mCurrentFocus|mFocusedApp'", "r");
        char buffer[128] = "";

        if (fp != NULL) {
            if (fgets(buffer, sizeof(buffer), fp) != NULL) {
                int game_found = 0;
                for (int i = 0; i < game_count; i++) {
                    if (strstr(buffer, games[i]) != NULL) {
                        game_found = 1;
                        break;
                    }
                }

                if (game_found) {
                    if (strcmp(prev_window_state, "active") != 0) {
                        strcpy(game_running, "open");
                        showToast("AllGame Priority: Game Opened Optimizing");
                        sleep(30);

                        char cmd[512];
                        snprintf(cmd, sizeof(cmd), "pgrep -f '%s'", buffer);
                        FILE *pid_fp = popen(cmd, "r");
                        if (pid_fp != NULL) {
                            char pid[16];
                            while (fgets(pid, sizeof(pid), pid_fp) != NULL) {
                                pid[strcspn(pid, "\n")] = 0;
                                setPriorities(pid);
                                sleep(1);
                            }
                            pclose(pid_fp);
                        }

                        showToast("AllGame Priority: Successfully Optimized");
                    }
                    strcpy(prev_window_state, "active");
                } else {
                    if (strcmp(game_running, "open") == 0) {
                        strcpy(game_running, "");
                        showToast("AllGame Priority: Game Closed");
                    }
                    strcpy(prev_window_state, "");
                }
            }
            pclose(fp);
        } else {
            sleep(1);
        }

        sleep(15);
    }

    return 0;
}