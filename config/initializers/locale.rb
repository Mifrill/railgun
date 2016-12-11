# Where the I18n library should search for translation files, include subfolders
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

# Set default locale to something other than :en
# I18n.default_locale = :ru