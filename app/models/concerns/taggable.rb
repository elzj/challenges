module Taggable
  extend ActiveSupport::Concern

  included do
    after_save :save_tags
  end

  # For each type of tag, define three methods:
  # fandom_names (returns string), fandom_names= (sets string), fandoms (returns tags)
  Tag::TYPES.each do |tag_type|
    define_method "#{tag_type.downcase}_names" do
      instance_variable_get("@#{tag_type.downcase}_names") || get_tag_names(tag_type)
    end
    define_method "#{tag_type.downcase}_names=" do |val|
      instance_variable_set("@#{tag_type.downcase}_names", val)
    end
    define_method "#{tag_type.downcase.pluralize}" do
      tags.where(type: tag_type)
    end
  end

  def get_tag_names(type)
    tags.where(type: type).pluck(:name).join(', ')
  end

  def save_tags
    new_tags = Tag::TYPES.map{ |tag_type|
      list = send("#{tag_type.downcase}_names")
      Tag.process_list(tag_type, list)
    }
    self.tags = new_tags.flatten.compact
  end
end