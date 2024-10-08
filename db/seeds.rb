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
  region.alert_feeds.create!(
    name: 'Puget Sound Alerts',
    url: nil,
    type: 'PugetSoundManualAlertFeed'
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
    region_identifier: 4,
    api_url: "http://buseta.wmata.com/onebusaway-api-webapp/",
    web_url: "http://buseta.wmata.com/",
    name: "Washington, D.C."
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

begin
  region = Region.create!({
    region_identifier: 11,
    api_url: "http://realtime.sdmts.com/api/",
    web_url: "http://realtime.sdmts.com/",
    name: "San Diego"
  })
  region.alert_feeds.create!(
    name: 'San Diego Alerts',
    url: nil,
    type: 'SanDiegoManualAlertFeed'
  )
rescue
end

begin
  region = Region.create!({
    region_identifier: 12,
    api_url: "https://www.oba4spokane.com/api/",
    web_url: "https://www.oba4spokane.com/",
    name: "Spokane"
  })
rescue
end

Regions.new.update_regions

if Rails.env.development?
  puget_sound = Region.find_by(region_identifier: 1)
  study = puget_sound.studies.create({
    name: 'Demo Survey',
    description: 'This is a demo survey'
  })
  survey = study.surveys.first
  q = survey.questions.create({
    position: 1,
    required: true,
    content_attributes: {
      type: 'text',
      label_text: 'What is your name?'
    }
  })

  30.times do
    resp = survey.survey_responses.build({
      user_identifier: SecureRandom.uuid
    })
    responses = [SurveyResponseContent.new({
      question_id: q.id,
      question_type: 'text',
      question_label: 'What is your name?',
      answer: 'John Doe'
    })]
    resp.upsert_responses(responses)
    resp.save
  end
end