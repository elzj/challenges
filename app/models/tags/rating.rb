class Rating < Tag
  def self.model_name; Tag.model_name; end

  DEFAULTS = [
    "General Audiences",
    "Teen And Up Audiences",
    "Mature",
    "Explicit",
    "Not Rated"
  ]
end