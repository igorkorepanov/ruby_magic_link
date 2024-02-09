# frozen_string_literal: true

require 'rake'

RSpec.describe 'Gem rake tasks' do # rubocop:disable RSpec/DescribeClass
  it 'generates a key' do
    load File.expand_path('../../lib/ruby_magic_link/tasks.rb', __dir__)
    Rake::Task.define_task(:environment)
    expect { Rake::Task['ruby_magic_link:generate_key'].invoke }.to output(/\h{32}/).to_stdout
  end
end
