require_relative '../lib/app'

RSpec.describe 'list_gems' do
  it 'returns an array' do
    expect(list_gems).to be_an(Array)
  end

  it 'each entry has a name key' do
    list_gems.each do |gem|
      expect(gem).to have_key(:name)
    end
  end

  it 'gems are sorted alphabetically' do
    names = list_gems.map { |g| g[:name] }
    expect(names).to eq(names.sort)
  end

  it 'has at least 10 gems' do
    expect(list_gems.length).to be >= 10
  end
end
