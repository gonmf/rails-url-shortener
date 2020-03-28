require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  # include Capybara::DSL
  # include Capybara::Assertions
  # include Warden::Test::Helpers

  test 'creates new link' do
    get new_link_path
    assert_equal 200, status

    post links_path, params: { url: "http://example#{rand(10000)}.com", code: SecureRandom.alphanumeric }
    assert_equal 302, status

    follow_redirect!
    assert_equal 200, status

    assert path.start_with?('/links/') && path.end_with?('/detail')
  end

  test 'link creation validates url' do
    get new_link_path
    assert_equal 200, status

    post links_path, params: { url: "ftp://invalid.url.com", code: SecureRandom.alphanumeric }
    assert_equal 302, status

    follow_redirect!
    assert_equal 200, status

    assert_equal path, new_link_path
  end

  # class ShowOldVersionTest < SitesControllerTest
  #   def setup
  #     @site = create :trial_site, created_at: Date.parse('2019-05-05')
  #     @customer = create :customer, :with_site, site_id: @site.id

  #     login_as @customer
  #   end

  #   def teardown
  #     Warden.test_reset!

  #     logout @customer
  #   end

  #   test 'it displays all non-deprecated tools' do
  #     visit site_path(@site)

  #     page.assert_selector('div.app-link', count: 9)
  #     page.assert_selector('div.app-group-title', count: 0)
  #   end

  #   test 'it displays deprecated social tools if already installed' do
  #     group = @site.groups.create!(
  #       site_id: @site.id,
  #       networks: 'fb',
  #       is_follow: true,
  #       is_floating: true
  #     )

  #     bar = WelcomeBar.create!(
  #       site_id: @site.id,
  #       description: 'Test',
  #       cta_label: 'Test',
  #       cta_url: 'http://test.com',
  #       color: 'native',
  #       size: 'medium'
  #     )

  #     visit site_path(@site.reload)

  #     page.assert_selector('div.app-link', count: 11)
  #     page.assert_selector('div.app-group-title', count: 0)
  #   end
  # end

  # class ShowNewVersionTest < SitesControllerTest
  #   def setup
  #     @site = create :trial_site, created_at: Date.parse('2018-05-05')
  #     @customer = create :customer, :with_site, site_id: @site.id

  #     login_as @customer
  #   end

  #   def teardown
  #     Warden.test_reset!

  #     logout @customer
  #   end

  #   test 'it displays the correct social tools for a no source site' do
  #     visit site_path(@site)

  #     page.assert_selector('div.app-link', count: 12)
  #     page.assert_selector('div.app-group-title', count: 3)
  #   end

  #   test 'it displays deprecated social tools on a no source site if already installed' do
  #     group = @site.groups.create!(
  #       site_id: @site.id,
  #       networks: 'fb',
  #       is_follow: true,
  #       is_floating: true
  #     )

  #     bar = WelcomeBar.create!(
  #       site_id: @site.id,
  #       description: 'Test',
  #       cta_label: 'Test',
  #       cta_url: 'http://test.com',
  #       color: 'native',
  #       size: 'medium'
  #     )

  #     visit site_path(@site.reload)

  #     page.assert_selector('div.app-link', count: 15)
  #     page.assert_selector('div.app-group-title', count: 4)
  #   end

  #   test 'it displays all social tools on a wordpress site' do
  #     @site.update_attribute(:source, 'wordpress')
  #     @site.update_attribute(:created_at, Date.today)

  #     visit site_path(@site)

  #     page.assert_selector('div.app-link', count: 15)
  #     page.assert_selector('div.app-group-title', count: 4)
  #     all('div.app-group-title')[2].assert_text('Follow Tools')
  #   end
  # end

  # class ShowCorrectLayoutForSiteTest < SitesControllerTest
  #   def setup
  #     @site = create :active_site
  #     @customer = create :customer, :with_site, site_id: @site.id

  #     login_as @customer
  #   end

  #   def teardown
  #     Warden.test_reset!

  #     logout @customer
  #   end

  #   test 'it displays the correct layout for a wordpress/shopify free site' do
  #     @site.tier_id = FREE_TIER_ID
  #     @site.source = ['wordpress', 'shopify'].sample
  #     @site.save!

  #     visit site_path(@site)

  #     page.assert_selector('#cta-nav a.nav-link', text: 'Upgrade Plan', visible: true)
  #     page.assert_selector('div.alert-info', count: 3)

  #     all('p.alert-title')[0].assert_text(/TOOLS/)

  #     idx = rand(0..2)

  #     all('div.alert-info a.button')[idx].assert_text('Upgrade Now!')

  #     page.assert_selector('div.app-link-wrapper .app-badge-group', count: 7, text: 'Tools')
  #   end

  #   test 'it displays the correct layout for a wordpress tools site' do
  #     @site.tier_id = TOOLS_TIER_ID
  #     @site.source = 'wordpress'
  #     @site.save!

  #     visit site_path(@site)

  #     page.assert_no_selector('#cta-nav a.nav-link', text: 'Upgrade Plan')
  #     page.assert_selector('div.alert-info', count: 3)

  #     all('p.alert-title')[0].assert_text(/START/)

  #     idx = rand(0..2)

  #     all('div.alert-info a.button')[idx].assert_text('Start Free Trial Now!')

  #     page.assert_no_selector('div.app-link-wrapper .app-badge-group', text: 'Tools')
  #   end

  #   test 'it displays the correct layout for a shopify tools site' do
  #     @site.tier_id = TOOLS_TIER_ID
  #     @site.source = 'shopify'
  #     @site.save!

  #     visit site_path(@site)

  #     page.assert_no_selector('#cta-nav a.nav-link', text: 'Upgrade Plan')
  #     page.assert_selector('div.alert-info', count: 3)

  #     all('p.alert-title')[0].assert_text(/START/)

  #     idx = rand(0..2)

  #     all('div.alert-info a.button')[idx].assert_text('Upgrade Now!')

  #     page.assert_no_selector('div.app-link-wrapper .app-badge-group', text: 'Tools')
  #   end
  # end
end
