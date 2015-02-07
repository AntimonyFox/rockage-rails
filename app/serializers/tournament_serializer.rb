class TournamentSerializer < ActiveModel::Serializer
  attributes :name, :slug, :max_num_entries, :spaces_available, :num_sign_ups

  has_one :bracket

  def spaces_available
    max_num_entries - Tournament.find_by_slug(slug).users.count
  end

  def num_sign_ups
    Tournament.find_by_slug(slug).users.count
  end
end
