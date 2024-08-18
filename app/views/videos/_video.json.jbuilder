json.extract! video, :id, :titulo, :canal, :youtube_id, :desejo, :created_at, :updated_at
json.url video_url(video, format: :json)
