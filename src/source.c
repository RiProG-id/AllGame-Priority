#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  int null_fd = open("/dev/null", O_WRONLY);
  dup2(null_fd, STDOUT_FILENO);
  dup2(null_fd, STDERR_FILENO);
  close(null_fd);

  {
    char cmd[512];
    snprintf(cmd, sizeof(cmd),
             "am start -a android.intent.action.MAIN -e toasttext \"%s\" -n "
             "bellavita.toast/.MainActivity",
             "AllGame Priority: By RiProG");
    system(cmd);
    sleep(2);
    snprintf(cmd, sizeof(cmd),
             "am start -a android.intent.action.MAIN -e toasttext \"%s\" -n "
             "bellavita.toast/.MainActivity",
             "Program is running in the background.");
    system(cmd);
  }

  char games[128][128];
  int game_count = 0;
  {
    const char *primaryPath = "/data/adb/modules/Priority/gamelist.txt";
    const char *secondaryPath = "/sdcard/Priority/gamelist.txt";
    const char *filePath = NULL;

    FILE *file = fopen(primaryPath, "r");
    if (file != NULL) {
      filePath = primaryPath;
    } else {
      file = fopen(secondaryPath, "r");
      if (file != NULL) {
        filePath = secondaryPath;
      }
    }

    char line[128];
    while (fgets(line, sizeof(line), file) != NULL && game_count < 128) {
      line[strcspn(line, "\n")] = '\0';
      if (strlen(line) == 0) {
        continue;
      }
      strncpy(games[game_count], line, sizeof(games[game_count]) - 1);
      games[game_count][sizeof(games[game_count]) - 1] = '\0';
      game_count++;
    }

    fclose(file);
  }

  char prev_window_state[10] = "";
  char game_running[10] = "";

  while (1) {
    system("clear");

    FILE *fp = popen("dumpsys activity top | grep ACTIVITY'", "r");
    char buffer[512] = "";

    if (fp != NULL) {
      if (fgets(buffer, sizeof(buffer), fp) != NULL) {
        int game_found = 0;
        char detected_game[128] = "";
        for (int i = 0; i < game_count; i++) {
          if (strstr(buffer, games[i]) != NULL) {
            game_found = 1;
            strncpy(detected_game, games[i], sizeof(detected_game) - 1);
            detected_game[sizeof(detected_game) - 1] = '\0';
            break;
          }
        }

        if (game_found) {

          if (strcmp(prev_window_state, "active") != 0) {
            strcpy(game_running, "open");

            {
              char cmd[512];
              snprintf(cmd, sizeof(cmd),
                       "am start -a android.intent.action.MAIN -e toasttext "
                       "\"%s\" -n bellavita.toast/.MainActivity",
                       "AllGame Priority: Game Opened Optimizing");
              system(cmd);
            }
            sleep(30);

            {
              char cmd[512];
              snprintf(cmd, sizeof(cmd), "pgrep -f %s", detected_game);
              FILE *pid_fp = popen(cmd, "r");
              if (pid_fp != NULL) {
                char pid[16];
                while (fgets(pid, sizeof(pid), pid_fp) != NULL) {
                  pid[strcspn(pid, "\n")] = 0;

                  snprintf(cmd, sizeof(cmd), "/proc/%s/task/", pid);
                  DIR *task_dir = opendir(cmd);
                  if (task_dir != NULL) {
                    struct dirent *task_entry;
                    while ((task_entry = readdir(task_dir)) != NULL) {
                      if (task_entry->d_type == DT_DIR &&
                          strcmp(task_entry->d_name, ".") != 0 &&
                          strcmp(task_entry->d_name, "..") != 0) {
                        snprintf(cmd, sizeof(cmd), "renice -n -20 -p %s",
                                 task_entry->d_name);
                        system(cmd);
                        snprintf(cmd, sizeof(cmd), "ionice -c 1 -n 0 -p %s",
                                 task_entry->d_name);
                        system(cmd);
                        snprintf(cmd, sizeof(cmd), "chrt -f -p 99 %s",
                                 task_entry->d_name);
                        system(cmd);
                      }
                    }
                    closedir(task_dir);
                  }
                  sleep(1);
                }
                pclose(pid_fp);
              }
            }

            {
              char cmd[512];
              snprintf(cmd, sizeof(cmd),
                       "am start -a android.intent.action.MAIN -e toasttext "
                       "\"%s\" -n bellavita.toast/.MainActivity",
                       "AllGame Priority: Successfully Optimized");
              system(cmd);
            }
          }
          strcpy(prev_window_state, "active");
        } else {
          if (strcmp(game_running, "open") == 0) {
            strcpy(game_running, "");
            char cmd[512];
            snprintf(cmd, sizeof(cmd),
                     "am start -a android.intent.action.MAIN -e toasttext "
                     "\"%s\" -n bellavita.toast/.MainActivity",
                     "AllGame Priority: Game Closed");
            system(cmd);
          }
          strcpy(prev_window_state, "");
        }
      }
      pclose(fp);
    } else {
      sleep(15);
    }

    sleep(15);
  }

  return 0;
}