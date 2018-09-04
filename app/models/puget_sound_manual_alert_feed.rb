class PugetSoundManualAlertFeed < ManualAlertFeed
  def agency_id
    # yes, it's intentionally a string. :-\
    # 40 == sound transit
    "40"
  end
end