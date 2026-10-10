{
  programs.nix-plist-manager = {
    enable = true;
    options.applications = {
      systemSettings = {
        appearance.appearance = "Auto";
        appearance.showScrollBars = "When scrolling";

        desktopAndDock = {
          desktopAndStageManager.showItems.onDesktop = false;

          dock = {
            animateOpeningApplications = false;
            automaticallyHideAndShowTheDock.enabled = true;
            magnification = {
              enabled = true;
              size = 76;
            };
            showIndicatorsForOpenApplications = false;
            showSuggestedAndRecentAppsInDock = false;
            size = 58;
          };

          missionControl = {
            automaticallyRearrangeSpacesBasedOnMostRecentUse = false;
            shortcuts = {
              applicationWindows = "-";
              missionControl = "-";
              showDesktop = "-";
            };
          };
        };

        desktopAndDock.desktopAndStageManager.clickWallpaperToRevealDesktop = "Only in Stage Manager";

        general = {
          airDropAndContinuity.airDrop = "No One";
          dateAndTime."24HourTime" = true;
          languageAndRegion = {
            preferredLanguages = [ "en-US" ];
            region = "en_US@rg=bezzzz";
          };
        };

        appleIntelligenceAndSiri.siri.enable = false;

        keyboard = {
          delayUntilRepeat = 10;
          keyRepeatRate = 1;
          keyboardShortcuts = {
            inputSources = {
              selectNextSourceInInputMenu = false;
              selectThePreviousInputSource = false;
            };
            screenshots = {
              copyPictureOfScreenToTheClipboard = false;
              copyPictureOfSelectedAreaToTheClipboard = false;
              savePictureOfScreenAsAFile = false;
              savePictureOfSelectedAreaAsAFile = false;
              screenshotAndRecordingOptions = false;
            };
          };
        };

        menuBar.clock = {
          displayTheTimeWithSeconds = false;
          showAmPm = false;
          showDate = false;
          showTheDayOfTheWeek = false;
          style = "Digital";
        };

        notifications.notificationCenter.summarizeNotifications = false;
        privacyAndSecurity = {
          appleAdvertising.personalizedAds = false;
        };

        desktopAndDock.windows.closeWindowsWhenQuittingAnApplication = true;

        trackpad = {
          pointAndClick.click = "Medium";
          scrollAndZoom = {
            naturalScrolling = false;
            rotate = true;
            zoomInOrOut = true;
          };
        };

        wallpaper.photo = ../../assets/wallpapers/wallpaper.jpg;
      };

      finder = {
        menuBar.view = {
          showPathBar = true;
          showStatusBar = true;
        };
        settings.advanced.showAllFilenameExtensions = true;
      };

    };
  };
}
