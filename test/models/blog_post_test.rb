# test/models/blog_post_test.rb

require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  fixtures :all
  test "draft? returns true for draft blog post" do
    assert draft_blog_post.draft?
  end

  test "draft? returns false for published blog post" do
    assert_not draft_blog_post.published?
  end

  test "draft? returns false for scheduled blog post" do
    assert_not draft_blog_post.scheduled?
  end

  test "published? return true for published blog post" do
    assert BlogPost.new(published_at: 1.year.ago).published?
  end

  test "published? return false for draft blog post" do
    assert_not BlogPost.new(published_at: nil).published?
  end

  test "published? return false for scheduled blog post" do
    assert_not BlogPost.new(published_at: 1.year.from_now).published?
  end

  test "scheduled? return true for scheduled blog post" do
    assert BlogPost.new(published_at: 1.year.from_now).scheduled?
  end

  test "scheduled? return false for draft blog post" do
    assert_not BlogPost.new(published_at: nil).scheduled?
  end


  test "scheduled? return false for published blog post" do
    assert_not BlogPost.new(published_at: 1.year.ago).scheduled?
  end

  def draft_blog_post
    BlogPost.new(published_at: nil)
  end

  private

  def get_post_body(post_id)
    ActionText::RichText.find_by(record_type: "BlogPost", record_id: post_id).body
  end

  def blog_posts(name)
    BlogPost.find_by(id: name.to_i)
  end
end
