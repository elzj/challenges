module Indexable
  extend ActiveSupport::Concern

  included do
    after_commit :reindex
  end

  class_methods do
    def index_name
      "challenges_#{Rails.env}_#{model_name.name.downcase.pluralize}"
    end

    def document_type
      model_name.name.downcase
    end

    def create_index
      search_client.indices.create(index: index_name)
    end

    def delete_index
      search_client.indices.delete(index: index_name)
    end

    def search_client
      Elasticsearch::Client.new host: '127.0.0.1:9400'
    end

    def search(query)
      search_client.search(
        index: index_name,
        type: document_type,
        body: query
      )
    end

    def suggest(term, options = {})
      body = {
        "_source" => "suggest",
        suggest: {
          autocomplete_me: {
            prefix: term,
            completion: {
              field: "suggest",
              contexts: options[:contexts] || {},
              size: options[:size] || 10
            }
          }
        }
      }
      results = search_client.search(
        index: index_name,
        type: document_type,
        body: body
      )
      results.dig('suggest', 'autocomplete_me').
              first['options'].
              map{ |r| r.dig('_source', 'suggest', 'input').first } rescue []
    end
  end

  def reindex
    client = self.class.search_client
    client.index(
      index: self.class.index_name,
      type: self.class.document_type,
      id: id,
      body: as_document
    )
  end

  def as_document
    as_json
  end
end
