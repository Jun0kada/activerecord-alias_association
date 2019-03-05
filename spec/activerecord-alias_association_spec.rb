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
        comment: [:review, :one_comment]
      },
      Comment => {
        user: [:owner, :commentor]
      }
    }
  end

  it 'should has alias method' do
    alias_associations.each do |klass, v|
      v.each do |old_method, new_methods|
        new_methods.each do |new_method|
          expect(klass.instance_method(new_method).original_name).to eq(klass.instance_method(old_method).name)
        end
      end
    end
  end

  context 'AR query methods' do
    let(:ar_query_methods) { [:includes, :preload, :eager_load] }

    before do
      team = Team.create(name: 'team')
      2.times do
        user = User.create(team: team, name: 'john')
        Comment.create(user: user, body: 'comment!')
      end
    end

    it 'can use alias association' do
      alias_associations.each do |klass, v|
        ar_query_methods.each do |query_method|
          v.each do |_, alias_associations|
            alias_associations.each do |alias_association|
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
            expect { klass.send(query_method, :not_alias_association).load }.to raise_error(/(Association named 'not_alias_association' was not found|association named 'not_alias_association')/)
          end
        end
      end
    end
  end
end
