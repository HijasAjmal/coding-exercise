module ApplicationHelper

  # loading assets based on controller name for simple and more customizable use
  def asset_present?(name)
    if Rails.application.assets.present?
      Rails.application.assets.find_asset(name)
    else
      Rails.application.assets_manifest.files.values.map { |v| v['logical_path'] }.include?(name)
    end
  end
end
