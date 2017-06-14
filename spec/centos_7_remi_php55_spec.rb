require 'spec_helper'

describe 'yum-remi-chef::remi-php55' do
  cached(:centos_7_remi_php55) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '7.3.1611'
    ) do |node|
      node.override['yum']['remi-php55']['enabled'] = true
      node.override['yum']['remi-php55']['managed'] = true
      node.override['yum']['remi-php55-debuginfo']['enabled'] = true
      node.override['yum']['remi-php55-debuginfo']['managed'] = true
    end.converge(described_recipe)
  end

  it 'creates yum_repository[remi-safe]' do
    expect(centos_7_remi_php55).to create_yum_repository('remi-safe')
  end

  %w(
    remi-php55
    remi-php55-debuginfo
  ).each do |repo|
    it "creates yum_repository[#{repo}]" do
      expect(centos_7_remi_php55).to create_yum_repository(repo)
    end
  end
end
