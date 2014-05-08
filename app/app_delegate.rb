class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    performChecks
  end

  def application(app, didFinishLaunchingWithOptions:options)
    performChecks
  end

  def performChecks
    reporter = PLCrashReporter.sharedReporter
    p reporter

    if reporter.hasPendingCrashReport
      handleCrashReport
    end

    pointer = Pointer.new(:object)
    unless reporter.enableCrashReporterAndReturnError(pointer)
      NSLog("Unable to enable crash reporting: #{pointer[0].inspect}")
    end

    performSelectorInBackground(:crash!, withObject:nil)
  end

  def crash!
    sec = 3
    NSLog("Enabled crash reporting, crashing in #{sec} sec")
    sleep sec
    doesNotExist
  end

  def handleCrashReport
    NSLog("handleCrashReport")
    reporter = PLCrashReporter.sharedReporter

    pointer = Pointer.new(:object)
    unless crashData = reporter.loadPendingCrashReportDataAndReturnError(pointer)
      NSLog("Unable to load crash report")
    else
     unless report = PLCrashReport.alloc.initWithData(crashData, error:pointer)
       NSLog("Could not parse crash report")
     else
       NSLog("Crashed on %@", report.systemInfo.timestamp)
       NSLog("Crashed with signal %@ (code %@, address=0x%x)", report.signalInfo.name, report.signalInfo.code, report.signalInfo.address)
     end
    end

    reporter.purgePendingCrashReport
  end
end
