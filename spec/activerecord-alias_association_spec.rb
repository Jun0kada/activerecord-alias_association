require 'spec_helper'

RSpec.describe Activerecord::AliasAssociation do
  let(:alias_associations) do
    {
      Team => {
        users: [:members, :team_members],
        comments: [:member_comments, :team_member_comments]
      },
      User => {
        team: [:club, :organization],
        comment: [:review, :one_comment],
        images: [:pictures]
      },
      Comment => {
        user: [:owner, :commentor],
        categories: [:tags],
        images: [:pictures]
      },
      Category => {
        comments: [:posts]
      },
      Image => {
        imageable: [:picturable]
      }
    }
  end

  context 'association alias defined methods' do
    it 'should has association methods' do
      alias_associations.each do |klass, v|
        v.each do |_, alias_associations|
          alias_associations.each do |alias_association|
            expect(klass.instance_methods.include?(alias_association)).to eq(true)
            expect(klass.instance_methods.include?("#{alias_association}=".to_sym)).to eq(true)

            reflection = klass.reflect_on_association(alias_association)

            case reflection.macro
            when :belongs_to, :has_one
              expect(klass.instance_methods.include?("reload_#{alias_association}".to_sym)).to eq(true)

              unless reflection.polymorphic?
                expect(klass.instance_methods.include?("build_#{alias_association}".to_sym)).to eq(true)
                expect(klass.instance_methods.include?("create_#{alias_association}".to_sym)).to eq(true)
                expect(klass.instance_methods.include?("create_#{alias_association}!".to_sym)).to eq(true)
              end
            when :has_many, :has_and_belongs_to_many
              expect(klass.instance_methods.include?("#{alias_association.to_s.singularize}_ids".to_sym)).to eq(true)
              expect(klass.instance_methods.include?("#{alias_association.to_s.singularize}_ids=".to_sym)).to eq(true)
            end
          end
        end
      end
    end
  end

  context 'AR query methods' do
    let(:ar_query_methods) { [:includes, :preload, :eager_load] }

    before do
      team = Team.create!(name: 'team')
      2.times do
        user = User.create!(team: team, name: 'john')
        user.images.create!
        comment = user.create_comment!(body: 'comment!')
        comment.categories.create!(name: 'category')
      end
    end

    it 'can use alias association' do
      alias_associations.each do |klass, v|
        ar_query_methods.each do |query_method|
          v.each do |_, alias_associations|
            alias_associations.each do |alias_association|
              next if klass.reflect_on_association(alias_association).polymorphic? && query_method == :eager_load

              expect { klass.send(query_method, alias_association).load }.not_to raise_error
            end
          end
        end
      end
    end

    context 'with not alias association' do
      it 'can not be used' do
        alias_associations.each do |klass, v|
          ar_query_methods.each do |query_method|
            expect {
              klass.send(query_method, :not_alias_association).load
            }.to raise_error(ActiveRecord::ConfigurationError, /not_alias_association/)
          end
        end
      end
    end
  end
end
