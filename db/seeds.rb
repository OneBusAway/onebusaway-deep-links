# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

begin
  Region.create!({
    region_identifier: 0,
    api_url: 'http://api.tampa.onebusaway.org/api/',
    web_url: 'http://tampa.onebusaway.org/',
    name: 'Tampa'
  })
rescue
end

begin
  region = Region.create!({
    region_identifier: 1,
    api_url: 'http://api.pugetsound.onebusaway.org/',
    web_url: 'http://pugetsound.onebusaway.org/',
    name: 'Puget Sound'
  })
  alert_feeds = {
    "Metro Transit Regional Trip Planner": "https://public.govdelivery.com/topics/WAKING_476/feed.rss",
    "Rapid Ride A Line": "https://public.govdelivery.com/topics/WAKCDOT_120/feed.rss",
    "Rapid Ride B Line": "https://public.govdelivery.com/topics/WAKCDOT_296/feed.rss",
    "Rapid Ride C Line": "https://public.govdelivery.com/topics/WAKCDOT_327/feed.rss",
    "Rapid Ride D Line": "https://public.govdelivery.com/topics/WAKCDOT_328/feed.rss",
    "Rapid Ride E Line": "https://public.govdelivery.com/topics/WAKING_480/feed.rss",
    "Rapid Ride F Line": "https://public.govdelivery.com/topics/WAKING_569/feed.rss",
    "Route 1": "https://public.govdelivery.com/topics/WAKCDOT_1/feed.rss",
    "Route 2": "https://public.govdelivery.com/topics/WAKCDOT_2/feed.rss",
    "Route 3": "https://public.govdelivery.com/topics/WAKCDOT_3/feed.rss",
    "Route 4": "https://public.govdelivery.com/topics/WAKCDOT_58/feed.rss",
    "Route 5": "https://public.govdelivery.com/topics/WAKCDOT_4/feed.rss",
    "Route 7": "https://public.govdelivery.com/topics/WAKCDOT_5/feed.rss",
    "Route 8": "https://public.govdelivery.com/topics/WAKCDOT_6/feed.rss",
    "Route 9": "https://public.govdelivery.com/topics/WAKCDOT_7/feed.rss",
    "Route 10": "https://public.govdelivery.com/topics/WAKCDOT_8/feed.rss",
    "Route 11": "https://public.govdelivery.com/topics/WAKCDOT_9/feed.rss",
    "Route 12": "https://public.govdelivery.com/topics/WAKCDOT_10/feed.rss",
    "Route 13": "https://public.govdelivery.com/topics/WAKCDOT_11/feed.rss",
    "Route 14": "https://public.govdelivery.com/topics/WAKCDOT_12/feed.rss",
    "Route 15": "https://public.govdelivery.com/topics/WAKCDOT_13/feed.rss",
    "Route 17": "https://public.govdelivery.com/topics/WAKCDOT_15/feed.rss",
    "Route 18": "https://public.govdelivery.com/topics/WAKCDOT_16/feed.rss",
    "Route 21": "https://public.govdelivery.com/topics/WAKCDOT_18/feed.rss",
    "Route 22": "https://public.govdelivery.com/topics/WAKCDOT_19/feed.rss",
    "Route 24": "https://public.govdelivery.com/topics/WAKCDOT_260/feed.rss",
    "Route 26": "https://public.govdelivery.com/topics/WAKCDOT_22/feed.rss",
    "Route 27": "https://public.govdelivery.com/topics/WAKCDOT_23/feed.rss",
    "Route 28": "https://public.govdelivery.com/topics/WAKCDOT_24/feed.rss",
    "Route 29": "https://public.govdelivery.com/topics/WAKCDOT_335/feed.rss",
    "Route 31": "https://public.govdelivery.com/topics/WAKCDOT_31/feed.rss",
    "Route 32": "https://public.govdelivery.com/topics/WAKCDOT_334/feed.rss",
    "Route 33": "https://public.govdelivery.com/topics/WAKCDOT_32/feed.rss",
    "Route 36": "https://public.govdelivery.com/topics/WAKCDOT_35/feed.rss",
    "Route 37": "https://public.govdelivery.com/topics/WAKCDOT_36/feed.rss",
    "Route 40": "https://public.govdelivery.com/topics/WAKCDOT_332/feed.rss",
    "Route 41": "https://public.govdelivery.com/topics/WAKCDOT_39/feed.rss",
    "Route 43": "https://public.govdelivery.com/topics/WAKCDOT_41/feed.rss",
    "Route 44": "https://public.govdelivery.com/topics/WAKCDOT_42/feed.rss",
    "Route 45": "https://public.govdelivery.com/topics/WAKCDOT_43/feed.rss",
    "Route 47": "https://public.govdelivery.com/topics/WAKCDOT_333/feed.rss",
    "Route 48": "https://public.govdelivery.com/topics/WAKCDOT_45/feed.rss",
    "Route 49": "https://public.govdelivery.com/topics/WAKCDOT_46/feed.rss",
    "Route 50": "https://public.govdelivery.com/topics/WAKCDOT_331/feed.rss",
    "Route 55": "https://public.govdelivery.com/topics/WAKCDOT_50/feed.rss",
    "Route 56": "https://public.govdelivery.com/topics/WAKCDOT_51/feed.rss",
    "Route 57": "https://public.govdelivery.com/topics/WAKCDOT_52/feed.rss",
    "Route 60": "https://public.govdelivery.com/topics/WAKCDOT_53/feed.rss",
    "Route 62": "https://public.govdelivery.com/topics/WAKCDOT_329/feed.rss",
    "Route 63": "https://public.govdelivery.com/topics/WAKING_891/feed.rss",
    "Route 64": "https://public.govdelivery.com/topics/WAKCDOT_54/feed.rss",
    "Route 65": "https://public.govdelivery.com/topics/WAKCDOT_55/feed.rss",
    "Route 67": "https://public.govdelivery.com/topics/WAKCDOT_57/feed.rss",
    "Route 70": "https://public.govdelivery.com/topics/WAKCDOT_60/feed.rss",
    "Route 71": "https://public.govdelivery.com/topics/WAKCDOT_61/feed.rss",
    "Route 73": "https://public.govdelivery.com/topics/WAKCDOT_63/feed.rss",
    "Route 74": "https://public.govdelivery.com/topics/WAKCDOT_64/feed.rss",
    "Route 75": "https://public.govdelivery.com/topics/WAKCDOT_65/feed.rss",
    "Route 76": "https://public.govdelivery.com/topics/WAKCDOT_66/feed.rss",
    "Route 77": "https://public.govdelivery.com/topics/WAKCDOT_67/feed.rss",
    "Route 78": "https://public.govdelivery.com/topics/WAKING_892/feed.rss",
    "Route 82 Night Owl": "https://public.govdelivery.com/topics/WAKCDOT_70/feed.rss",
    "Route 83 Night Owl": "https://public.govdelivery.com/topics/WAKCDOT_71/feed.rss",
    "Route 84 Night Owl": "https://public.govdelivery.com/topics/WAKCDOT_72/feed.rss",
    "Route 90 Downtown/First Hill Snow Service": "https://public.govdelivery.com/topics/WAKCDOT_281/feed.rss",
    "Route 99": "https://public.govdelivery.com/topics/WAKCDOT_76/feed.rss",
    "Route 101": "https://public.govdelivery.com/topics/WAKCDOT_77/feed.rss",
    "Route 102": "https://public.govdelivery.com/topics/WAKCDOT_78/feed.rss",
    "Route 105": "https://public.govdelivery.com/topics/WAKCDOT_79/feed.rss",
    "Route 106": "https://public.govdelivery.com/topics/WAKCDOT_80/feed.rss",
    "Route 107": "https://public.govdelivery.com/topics/WAKCDOT_81/feed.rss",
    "Route 111": "https://public.govdelivery.com/topics/WAKCDOT_83/feed.rss",
    "Route 113": "https://public.govdelivery.com/topics/WAKCDOT_84/feed.rss",
    "Route 114": "https://public.govdelivery.com/topics/WAKCDOT_85/feed.rss",
    "Route 116": "https://public.govdelivery.com/topics/WAKCDOT_86/feed.rss",
    "Route 118": "https://public.govdelivery.com/topics/WAKCDOT_87/feed.rss",
    "Route 119": "https://public.govdelivery.com/topics/WAKCDOT_88/feed.rss",
    "Route 120": "https://public.govdelivery.com/topics/WAKCDOT_89/feed.rss",
    "Route 121": "https://public.govdelivery.com/topics/WAKCDOT_90/feed.rss",
    "Route 122": "https://public.govdelivery.com/topics/WAKCDOT_91/feed.rss",
    "Route 123": "https://public.govdelivery.com/topics/WAKCDOT_92/feed.rss",
    "Route 124": "https://public.govdelivery.com/topics/WAKCDOT_93/feed.rss",
    "Route 125": "https://public.govdelivery.com/topics/WAKCDOT_94/feed.rss",
    "Route 128": "https://public.govdelivery.com/topics/WAKCDOT_95/feed.rss",
    "Route 131": "https://public.govdelivery.com/topics/WAKCDOT_97/feed.rss",
    "Route 132": "https://public.govdelivery.com/topics/WAKCDOT_257/feed.rss",
    "Route 143": "https://public.govdelivery.com/topics/WAKCDOT_102/feed.rss",
    "Route 148": "https://public.govdelivery.com/topics/WAKCDOT_103/feed.rss",
    "Route 150": "https://public.govdelivery.com/topics/WAKCDOT_105/feed.rss",
    "Route 153": "https://public.govdelivery.com/topics/WAKCDOT_107/feed.rss",
    "Route 154": "https://public.govdelivery.com/topics/WAKCDOT_108/feed.rss",
    "Route 156": "https://public.govdelivery.com/topics/WAKCDOT_282/feed.rss",
    "Route 157": "https://public.govdelivery.com/topics/WAKCDOT_110/feed.rss",
    "Route 158": "https://public.govdelivery.com/topics/WAKCDOT_111/feed.rss",
    "Route 159": "https://public.govdelivery.com/topics/WAKCDOT_112/feed.rss",
    "Route 164": "https://public.govdelivery.com/topics/WAKCDOT_115/feed.rss",
    "Route 166": "https://public.govdelivery.com/topics/WAKCDOT_116/feed.rss",
    "Route 167": "https://public.govdelivery.com/topics/WAKCDOT_29/feed.rss",
    "Route 168": "https://public.govdelivery.com/topics/WAKCDOT_117/feed.rss",
    "Route 169": "https://public.govdelivery.com/topics/WAKCDOT_118/feed.rss",
    "Route 177": "https://public.govdelivery.com/topics/WAKCDOT_122/feed.rss",
    "Route 178": "https://public.govdelivery.com/topics/WAKCDOT_320/feed.rss",
    "Route 179": "https://public.govdelivery.com/topics/WAKCDOT_258/feed.rss",
    "Route 180": "https://public.govdelivery.com/topics/WAKCDOT_123/feed.rss",
    "Route 181": "https://public.govdelivery.com/topics/WAKCDOT_124/feed.rss",
    "Route 182": "https://public.govdelivery.com/topics/WAKCDOT_125/feed.rss",
    "Route 183": "https://public.govdelivery.com/topics/WAKCDOT_126/feed.rss",
    "Route 186": "https://public.govdelivery.com/topics/WAKCDOT_230/feed.rss",
    "Route 187": "https://public.govdelivery.com/topics/WAKCDOT_127/feed.rss",
    "Route 190": "https://public.govdelivery.com/topics/WAKCDOT_128/feed.rss",
    "Route 192": "https://public.govdelivery.com/topics/WAKCDOT_129/feed.rss",
    "Route 193": "https://public.govdelivery.com/topics/WAKCDOT_240/feed.rss",
    "Route 197": "https://public.govdelivery.com/topics/WAKCDOT_132/feed.rss",
    "Route 200": "https://public.govdelivery.com/topics/WAKCDOT_133/feed.rss",
    "Route 201": "https://public.govdelivery.com/topics/WAKCDOT_134/feed.rss",
    "Route 204": "https://public.govdelivery.com/topics/WAKCDOT_137/feed.rss",
    "Route 208": "https://public.govdelivery.com/topics/WAKING_399/feed.rss",
    "Route 212": "https://public.govdelivery.com/topics/WAKCDOT_144/feed.rss",
    "Route 214": "https://public.govdelivery.com/topics/WAKCDOT_146/feed.rss",
    "Route 216": "https://public.govdelivery.com/topics/WAKCDOT_148/feed.rss",
    "Route 217": "https://public.govdelivery.com/topics/WAKCDOT_149/feed.rss",
    "Route 218": "https://public.govdelivery.com/topics/WAKCDOT_150/feed.rss",
    "Route 219": "https://public.govdelivery.com/topics/WAKCDOT_151/feed.rss",
    "Route 221": "https://public.govdelivery.com/topics/WAKCDOT_152/feed.rss",
    "Route 224": "https://public.govdelivery.com/topics/WAKCDOT_238/feed.rss",
    "Route 226": "https://public.govdelivery.com/topics/WAKCDOT_297/feed.rss",
    "Route 232": "https://public.govdelivery.com/topics/WAKCDOT_156/feed.rss",
    "Route 234": "https://public.govdelivery.com/topics/WAKCDOT_158/feed.rss",
    "Route 235": "https://public.govdelivery.com/topics/WAKCDOT_298/feed.rss",
    "Route 236": "https://public.govdelivery.com/topics/WAKCDOT_159/feed.rss",
    "Route 237": "https://public.govdelivery.com/topics/WAKCDOT_160/feed.rss",
    "Route 238": "https://public.govdelivery.com/topics/WAKCDOT_161/feed.rss",
    "Route 240": "https://public.govdelivery.com/topics/WAKCDOT_28/feed.rss",
    "Route 241": "https://public.govdelivery.com/topics/WAKCDOT_299/feed.rss",
    "Route 243": "https://public.govdelivery.com/topics/WAKCDOT_163/feed.rss",
    "Route 244": "https://public.govdelivery.com/topics/WAKCDOT_164/feed.rss",
    "Route 245": "https://public.govdelivery.com/topics/WAKCDOT_165/feed.rss",
    "Route 246": "https://public.govdelivery.com/topics/WAKCDOT_275/feed.rss",
    "Route 248": "https://public.govdelivery.com/topics/WAKCDOT_167/feed.rss",
    "Route 249": "https://public.govdelivery.com/topics/WAKCDOT_168/feed.rss",
    "Route 252": "https://public.govdelivery.com/topics/WAKCDOT_171/feed.rss",
    "Route 255": "https://public.govdelivery.com/topics/WAKCDOT_256/feed.rss",
    "Route 257": "https://public.govdelivery.com/topics/WAKCDOT_174/feed.rss",
    "Route 268": "https://public.govdelivery.com/topics/WAKCDOT_179/feed.rss",
    "Route 269": "https://public.govdelivery.com/topics/WAKCDOT_180/feed.rss",
    "Route 271": "https://public.govdelivery.com/topics/WAKCDOT_181/feed.rss",
    "Route 277": "https://public.govdelivery.com/topics/WAKCDOT_183/feed.rss",
    "Route 301": "https://public.govdelivery.com/topics/WAKCDOT_186/feed.rss",
    "Route 303": "https://public.govdelivery.com/topics/WAKCDOT_187/feed.rss",
    "Route 304": "https://public.govdelivery.com/topics/WAKCDOT_188/feed.rss",
    "Route 308": "https://public.govdelivery.com/topics/WAKCDOT_190/feed.rss",
    "Route 309": "https://public.govdelivery.com/topics/WAKCDOT_288/feed.rss",
    "Route 311": "https://public.govdelivery.com/topics/WAKCDOT_191/feed.rss",
    "Route 312": "https://public.govdelivery.com/topics/WAKCDOT_192/feed.rss",
    "Route 316": "https://public.govdelivery.com/topics/WAKCDOT_193/feed.rss",
    "Route 330": "https://public.govdelivery.com/topics/WAKCDOT_194/feed.rss",
    "Route 331": "https://public.govdelivery.com/topics/WAKCDOT_195/feed.rss",
    "Route 342": "https://public.govdelivery.com/topics/WAKCDOT_196/feed.rss",
    "Route 345": "https://public.govdelivery.com/topics/WAKCDOT_197/feed.rss",
    "Route 346": "https://public.govdelivery.com/topics/WAKCDOT_198/feed.rss",
    "Route 347": "https://public.govdelivery.com/topics/WAKCDOT_199/feed.rss",
    "Route 348": "https://public.govdelivery.com/topics/WAKCDOT_200/feed.rss",
    "Route 355": "https://public.govdelivery.com/topics/WAKCDOT_201/feed.rss",
    "Route 372": "https://public.govdelivery.com/topics/WAKCDOT_203/feed.rss",
    "Route 373": "https://public.govdelivery.com/topics/WAKCDOT_204/feed.rss",
    "ST 522": "https://public.govdelivery.com/topics/WAKCDOT_205/feed.rss",
    "ST 540": "https://public.govdelivery.com/topics/WAKCDOT_206/feed.rss",
    "ST 541": "https://public.govdelivery.com/topics/WAKING_893/feed.rss",
    "ST 542": "https://public.govdelivery.com/topics/WAKCDOT_279/feed.rss",
    "ST 545": "https://public.govdelivery.com/topics/WAKCDOT_259/feed.rss",
    "ST 550": "https://public.govdelivery.com/topics/WAKCDOT_207/feed.rss",
    "ST 554": "https://public.govdelivery.com/topics/WAKCDOT_208/feed.rss",
    "ST 555": "https://public.govdelivery.com/topics/WAKCDOT_209/feed.rss",
    "ST 556": "https://public.govdelivery.com/topics/WAKCDOT_210/feed.rss",
    "Route 601 / G H C": "https://public.govdelivery.com/topics/WAKCDOT_321/feed.rss",
    "Community Shuttle Route 628": "https://public.govdelivery.com/topics/WAKING_689/feed.rss",
    "Community Shuttle Route 630": "https://public.govdelivery.com/topics/WAKING_766/feed.rss",
    "Community Shuttle Route 631": "https://public.govdelivery.com/topics/WAKCDOT_767/feed.rss",
    "DART 773": "https://public.govdelivery.com/topics/WAKCDOT_216/feed.rss",
    "DART 775": "https://public.govdelivery.com/topics/WAKCDOT_217/feed.rss",
    "School Route 823": "https://public.govdelivery.com/topics/WAKCDOT_141/feed.rss",
    "School Route 824": "https://public.govdelivery.com/topics/WAKCDOT_278/feed.rss",
    "School Route 887": "https://public.govdelivery.com/topics/WAKCDOT_322/feed.rss",
    "School Route 888": "https://public.govdelivery.com/topics/WAKCDOT_220/feed.rss",
    "School Route 889": "https://public.govdelivery.com/topics/WAKCDOT_294/feed.rss",
    "School Route 891": "https://public.govdelivery.com/topics/WAKCDOT_326/feed.rss",
    "School Route 892": "https://public.govdelivery.com/topics/WAKCDOT_222/feed.rss",
    "School Route 893": "https://public.govdelivery.com/topics/WAKCDOT_295/feed.rss",
    "DART 901": "https://public.govdelivery.com/topics/WAKCDOT_223/feed.rss",
    "DART 903": "https://public.govdelivery.com/topics/WAKCDOT_224/feed.rss",
    "DART 906": "https://public.govdelivery.com/topics/WAKCDOT_402/feed.rss",
    "DART 907": "https://public.govdelivery.com/topics/WAKCDOT_302/feed.rss",
    "DART 908": "https://public.govdelivery.com/topics/WAKCDOT_225/feed.rss",
    "DART 910": "https://public.govdelivery.com/topics/WAKCDOT_280/feed.rss",
    "DART 913": "https://public.govdelivery.com/topics/WAKCDOT_228/feed.rss",
    "DART 914": "https://public.govdelivery.com/topics/WAKCDOT_229/feed.rss",
    "DART 915": "https://public.govdelivery.com/topics/WAKCDOT_303/feed.rss",
    "DART 916": "https://public.govdelivery.com/topics/WAKCDOT_231/feed.rss",
    "DART 917": "https://public.govdelivery.com/topics/WAKCDOT_232/feed.rss",
    "DART 930": "https://public.govdelivery.com/topics/WAKCDOT_238/feed.rss",
    "DART 931": "https://public.govdelivery.com/topics/WAKCDOT_304/feed.rss",
    "Route 980": "https://public.govdelivery.com/topics/WAKCDOT_300/feed.rss",
    "Route 981": "https://public.govdelivery.com/topics/WAKCDOT_242/feed.rss",
    "Route 982": "https://public.govdelivery.com/topics/WAKCDOT_243/feed.rss",
    "Route 984": "https://public.govdelivery.com/topics/WAKCDOT_244/feed.rss",
    "Route 986": "https://public.govdelivery.com/topics/WAKCDOT_245/feed.rss",
    "Route 987": "https://public.govdelivery.com/topics/WAKCDOT_246/feed.rss",
    "Route 988": "https://public.govdelivery.com/topics/WAKCDOT_247/feed.rss",
    "Route 989": "https://public.govdelivery.com/topics/WAKCDOT_248/feed.rss",
    "Route 994": "https://public.govdelivery.com/topics/WAKCDOT_249/feed.rss",
    "Route 995": "https://public.govdelivery.com/topics/WAKCDOT_250/feed.rss",
    "King County-operated First Hill Streetcar (96)": "https://public.govdelivery.com/topics/WAKING_847/feed.rss",
    "King County-operated South Lake Union Streetcar (98)": "https://public.govdelivery.com/topics/WAKCDOT_251/feed.rss",
    "King County-operated Vashon Water Taxi (975)": "https://public.govdelivery.com/topics/WAKCDOT_252/feed.rss",
    "King County-operated West Seattle Water Taxi (973)": "https://public.govdelivery.com/topics/WAKCDOT_253/feed.rss",
    "Snoqualmie Valley Transportation (629)": "https://public.govdelivery.com/topics/WAKING_695/feed.rss",
    "Trolley Motorization": "https://public.govdelivery.com/topics/WAKCDOT_266/feed.rss"
  }
  alert_feeds.each do |key, value|
    region.alert_feeds.create!(
      name: key,
      url: value,
      type: 'KingCountyMetroAlertFeed'
    )
  end
  region.alert_feeds.create!(
    name: 'Sound Transit',
    url: 'http://m.soundtransit.org/schedules/alerts.xml',
    type: 'SoundTransitAlertFeed'
  )
rescue
end

begin
  Region.create!({
    region_identifier: 2,
    api_url: 'http://bustime.mta.info/',
    web_url: 'http://bustime.mta.info/',
    name: 'MTA New York'
  })
rescue
end

begin
  Region.create!({
    region_identifier: 3,
    api_url: "http://atlanta.onebusaway.org/api/",
    web_url: "http://atlanta.onebusaway.org/",
    name: "Atlanta"
  })
rescue
end

begin
  Region.create!({
    region_identifier: 4,
    api_url: "http://buseta.wmata.com/onebusaway-api-webapp/",
    web_url: "http://buseta.wmata.com/",
    name: "Washington, D.C."
  })
rescue
end

begin
  Region.create!({
    region_identifier: 5,
    api_url: "http://oba.yrt.ca/",
    web_url: "https://www.yrt.ca/",
    name: "York"
  })
rescue
end

begin
  Region.create!({
    region_identifier: 6,
    api_url: "http://bt.v-a.io/onebusaway/",
    web_url: "http://bt.v-a.io/",
    name: "Bear Transit"
  })
rescue
end

# begin
# Region.create!({
#   region_identifier: 7,
#   api_url: "http://developer.onebusaway.org/mbta-api/",
#   web_url: "TODO",
#   name: "Boston"
# })
# rescue
# end

# begin
# Region.create!({
#   region_identifier: 8,
#   api_url: "http://194.89.230.196:8080/",
#   web_url: "TODO",
#   name: "Lappeenranta"
# })
# rescue
# end

begin
  Region.create!({
    region_identifier: 9,
    api_url: "http://oba.rvtd.org:8080/onebusaway-api-webapp/",
    web_url: "http://oba.rvtd.org:8080/onebusaway-webapp/",
    name: "Rogue Valley, Oregon"
  })
rescue
end

begin
  Region.create!({
    region_identifier: 10,
    api_url: "http://www.obartd.com/onebusaway-api-webapp/",
    web_url: "http://www.obartd.com/onebusaway-webapp/",
    name: "San Joaquin RTD"
  })
rescue
end

begin
  Region.create!({
    region_identifier: 11,
    api_url: "http://realtime.sdmts.com/api/",
    web_url: "http://realtime.sdmts.com/",
    name: "San Diego"
  })
rescue
end
