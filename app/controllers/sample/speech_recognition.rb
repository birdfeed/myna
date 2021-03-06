# frozen_string_literal: true
module Controllers
  module Sample
    class SpeechRecognition < ::Controllers::Base
      ensure_record

      def perform_async
        record.hypothesis =
          Services::Samples::SpeechRecognition
          .compute_hypothesis(record)
          .to_s

        record.save

        Kagu::Events::PostgresProducer.call(record)
      end
    end
  end
end
