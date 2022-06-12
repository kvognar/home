module Taggable
  extend ActiveSupport::Concern

  included do
    acts_as_nested_set
    before_validation :standardize_name
    validates :name, uniqueness: true
  end

  class_methods do
    def recursive_create(name_chain)
      names = name_chain.split('::')
      transaction do
        current_tag = self.find_or_create_by(name: names.first)
        names.drop(1).each do |name|
          current_tag = current_tag.children.find_or_create_by(name: name)
        end
        current_tag
      end
    end

  end

  private

  def standardize_name
    self.name = self.name.downcase.strip
  end

end
