class Category < Tag
  def self.model_name; Tag.model_name; end

  DEFAULTS = [
    'Gen', 'F/F', 'F/M', 'M/M', 'Multi', 'Other'
  ]
end
