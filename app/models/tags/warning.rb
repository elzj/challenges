class Warning < Tag
  def self.model_name; Tag.model_name; end

  DEFAULTS = [
    "No Archive Warnings Apply",
    "Rape/Non-Con",
    "Graphic Depictions Of Violence",
    "Major Character Death",
    "Underage",
    "Choose Not To Use Archive Warnings"
  ]
end