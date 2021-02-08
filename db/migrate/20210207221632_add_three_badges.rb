class AddThreeBadges < ActiveRecord::Migration
  def up
    Badge.create(
        name: 'fun',
        description: 'This was a lot of fun'
    )
    Badge.create(
        name: 'resonate',
        description: 'This resonated with me'
    )
    Badge.create(
        name: 'great',
        description: 'This was great'
    )
  end

  def down
    Badge.where(name: %w[fun resonate great]).destroy_all
  end
end
