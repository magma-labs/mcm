module Mcm
  class YoutubeVideoComponent < BaseComponent
    def defaults
      { height: 400, width: 560 }
    end

    def youtube_url
      "https://www.youtube.com/embed/#{@component.metadata.youtube_video_id}"
    end
  end
end
