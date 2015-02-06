class TournamentSerializer < ActiveModel::Serializer
  attributes :name, :slug, :max_num_entries, :spaces_available

  has_one :bracket

  def spaces_available
    max_num_entries - Tournament.find_by_slug(slug).users.count
  end
end
