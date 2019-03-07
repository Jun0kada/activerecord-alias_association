require 'spec_helper'

RSpec.describe Activerecord::AliasAssociation do
  it 'should respond to association accessor methods' do
    # association
    expect(Team.new.respond_to?(:members)).to eq(true)
    expect(Team.new.respond_to?(:team_members)).to eq(true)
    expect(Team.new.respond_to?(:member_comments)).to eq(true)
    expect(Team.new.respond_to?(:team_member_comments)).to eq(true)
    expect(User.new.respond_to?(:review)).to eq(true)
    expect(User.new.respond_to?(:one_comment)).to eq(true)
    expect(User.new.respond_to?(:club)).to eq(true)
    expect(User.new.respond_to?(:organization)).to eq(true)
    expect(User.new.respond_to?(:pictures)).to eq(true)
    expect(Comment.new.respond_to?(:owner)).to eq(true)
    expect(Comment.new.respond_to?(:commentor)).to eq(true)
    expect(Comment.new.respond_to?(:pictures)).to eq(true)
    expect(Comment.new.respond_to?(:tags)).to eq(true)
    expect(Category.new.respond_to?(:posts)).to eq(true)
    expect(Image.new.respond_to?(:picturable)).to eq(true)

    # association=
    expect(Team.new.respond_to?(:members=)).to eq(true)
    expect(Team.new.respond_to?(:team_members=)).to eq(true)
    expect(Team.new.respond_to?(:member_comments=)).to eq(true)
    expect(Team.new.respond_to?(:team_member_comments=)).to eq(true)
    expect(User.new.respond_to?(:review=)).to eq(true)
    expect(User.new.respond_to?(:one_comment=)).to eq(true)
    expect(User.new.respond_to?(:club=)).to eq(true)
    expect(User.new.respond_to?(:organization=)).to eq(true)
    expect(User.new.respond_to?(:pictures=)).to eq(true)
    expect(Comment.new.respond_to?(:owner=)).to eq(true)
    expect(Comment.new.respond_to?(:commentor=)).to eq(true)
    expect(Comment.new.respond_to?(:pictures=)).to eq(true)
    expect(Comment.new.respond_to?(:tags=)).to eq(true)
    expect(Category.new.respond_to?(:posts=)).to eq(true)
    expect(Image.new.respond_to?(:picturable=)).to eq(true)
  end

  context 'with DB data' do
    before do
      Team.create!
      User.create!
      Comment.create!
      Category.create!
      Image.create!
    end

    it 'should call AR query methods' do
      # includes
      expect { Team.includes(:members).load }.not_to raise_error
      expect { Team.includes(:team_members).load }.not_to raise_error
      expect { Team.includes(:member_comments).load }.not_to raise_error
      expect { Team.includes(:team_member_comments).load }.not_to raise_error
      expect { User.includes(:review).load }.not_to raise_error
      expect { User.includes(:one_comment).load }.not_to raise_error
      expect { User.includes(:club).load }.not_to raise_error
      expect { User.includes(:organization).load }.not_to raise_error
      expect { User.includes(:pictures).load }.not_to raise_error
      expect { Comment.includes(:owner).load }.not_to raise_error
      expect { Comment.includes(:commentor).load }.not_to raise_error
      expect { Comment.includes(:pictures).load }.not_to raise_error
      expect { Comment.includes(:tags).load }.not_to raise_error
      expect { Category.includes(:posts).load }.not_to raise_error
      expect { Image.includes(:picturable).load }.not_to raise_error

      # preload
      expect { Team.preload(:members).load }.not_to raise_error
      expect { Team.preload(:team_members).load }.not_to raise_error
      expect { Team.preload(:member_comments).load }.not_to raise_error
      expect { Team.preload(:team_member_comments).load }.not_to raise_error
      expect { User.preload(:review).load }.not_to raise_error
      expect { User.preload(:one_comment).load }.not_to raise_error
      expect { User.preload(:club).load }.not_to raise_error
      expect { User.preload(:organization).load }.not_to raise_error
      expect { User.preload(:pictures).load }.not_to raise_error
      expect { Comment.preload(:owner).load }.not_to raise_error
      expect { Comment.preload(:commentor).load }.not_to raise_error
      expect { Comment.preload(:pictures).load }.not_to raise_error
      expect { Comment.preload(:tags).load }.not_to raise_error
      expect { Category.preload(:posts).load }.not_to raise_error
      expect { Image.preload(:picturable).load }.not_to raise_error

      # eager_load
      expect { Team.eager_load(:members).load }.not_to raise_error
      expect { Team.eager_load(:team_members).load }.not_to raise_error
      expect { Team.eager_load(:member_comments).load }.not_to raise_error
      expect { Team.eager_load(:team_member_comments).load }.not_to raise_error
      expect { User.eager_load(:review).load }.not_to raise_error
      expect { User.eager_load(:one_comment).load }.not_to raise_error
      expect { User.eager_load(:club).load }.not_to raise_error
      expect { User.eager_load(:organization).load }.not_to raise_error
      expect { User.eager_load(:pictures).load }.not_to raise_error
      expect { Comment.eager_load(:owner).load }.not_to raise_error
      expect { Comment.eager_load(:commentor).load }.not_to raise_error
      expect { Comment.eager_load(:pictures).load }.not_to raise_error
      expect { Comment.eager_load(:tags).load }.not_to raise_error
      expect { Category.eager_load(:posts).load }.not_to raise_error
    end
  end

  context 'when reflection is SingularAssociation' do
    it 'should respond to singular asssociation accessor & constructor methods' do
      # build_association
      expect(User.new.respond_to?(:build_review)).to eq(true)
      expect(User.new.respond_to?(:build_one_comment)).to eq(true)
      expect(User.new.respond_to?(:build_club)).to eq(true)
      expect(User.new.respond_to?(:build_organization)).to eq(true)
      expect(Comment.new.respond_to?(:build_owner)).to eq(true)
      expect(Comment.new.respond_to?(:build_commentor)).to eq(true)

      # create_association
      expect(User.new.respond_to?(:create_review)).to eq(true)
      expect(User.new.respond_to?(:create_one_comment)).to eq(true)
      expect(User.new.respond_to?(:create_club)).to eq(true)
      expect(User.new.respond_to?(:create_organization)).to eq(true)
      expect(Comment.new.respond_to?(:create_owner)).to eq(true)
      expect(Comment.new.respond_to?(:create_commentor)).to eq(true)

      # create_association!
      expect(User.new.respond_to?(:create_review!)).to eq(true)
      expect(User.new.respond_to?(:create_one_comment!)).to eq(true)
      expect(User.new.respond_to?(:create_club!)).to eq(true)
      expect(User.new.respond_to?(:create_organization!)).to eq(true)
      expect(Comment.new.respond_to?(:create_owner!)).to eq(true)
      expect(Comment.new.respond_to?(:create_commentor!)).to eq(true)

      # reload_association
      expect(User.new.respond_to?(:reload_review)).to eq(true)
      expect(User.new.respond_to?(:reload_one_comment)).to eq(true)
      expect(User.new.respond_to?(:reload_club)).to eq(true)
      expect(User.new.respond_to?(:reload_organization)).to eq(true)
      expect(Comment.new.respond_to?(:reload_owner)).to eq(true)
      expect(Comment.new.respond_to?(:reload_commentor)).to eq(true)
      expect(Image.new.respond_to?(:reload_picturable)).to eq(true)
    end
  end

  context 'when reflection is CollectionAssociation' do
    it 'should respond to collection association accessor methods' do
      # collection_singular_ids
      expect(Team.new.respond_to?(:member_ids)).to eq(true)
      expect(Team.new.respond_to?(:team_member_ids)).to eq(true)
      expect(Team.new.respond_to?(:member_comment_ids)).to eq(true)
      expect(Team.new.respond_to?(:team_member_comment_ids)).to eq(true)
      expect(User.new.respond_to?(:picture_ids)).to eq(true)
      expect(Comment.new.respond_to?(:picture_ids)).to eq(true)
      expect(Comment.new.respond_to?(:tag_ids)).to eq(true)
      expect(Category.new.respond_to?(:post_ids)).to eq(true)

      # collection_singular_ids=
      expect(Team.new.respond_to?(:member_ids=)).to eq(true)
      expect(Team.new.respond_to?(:team_member_ids=)).to eq(true)
      expect(Team.new.respond_to?(:member_comment_ids=)).to eq(true)
      expect(Team.new.respond_to?(:team_member_comment_ids=)).to eq(true)
      expect(User.new.respond_to?(:picture_ids=)).to eq(true)
      expect(Comment.new.respond_to?(:picture_ids=)).to eq(true)
      expect(Comment.new.respond_to?(:tag_ids=)).to eq(true)
      expect(Category.new.respond_to?(:post_ids=)).to eq(true)
    end
  end
end

RSpec.describe 'AR query methods' do
  before do
    Team.create!
    User.create!
    Comment.create!
    Category.create!
    Image.create!
  end

  context 'when exists association' do
    it 'should call AR query methods' do
      expect { Team.includes(:users).load }.not_to raise_error
      expect { Team.preload(:users).load }.not_to raise_error
      expect { Team.eager_load(:users).load }.not_to raise_error
    end
  end

  context 'when not exists association' do
    it 'should raise error' do
      expect { Team.includes(:not_exist_association).load }.to raise_error(ActiveRecord::ConfigurationError)
      expect { Team.preload(:not_exist_association).load }.to raise_error(ActiveRecord::ConfigurationError)
      expect { Team.eager_load(:not_exist_association).load }.to raise_error(ActiveRecord::ConfigurationError)
    end
  end
end
