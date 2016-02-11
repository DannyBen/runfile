# Stepdefs courtesy of Clicumber
# https://github.com/DannyBen/clicumber

# Hooks

# Undo the "change dir" step if needed
Before do
  next unless $original_dir
  Dir.chdir $original_dir
  $original_dir = nil
end

# Given

Given(/^I am in the "([^"]+)" (?:folder|dir|directory)$/) do |dir|
  $original_dir = Dir.pwd
  Dir.chdir dir
end

Given(/^the file "([^"]*)" exists$/) do |file|
  File.write(file, 'stub') unless File.exist? file
end

Given(/^the (?:folder|dir|directory) "([^"]*)" exists$/) do |dir|
  Dir.mkdir(dir) unless Dir.exist? dir
end

Given(/^the file "([^"]*)" has the content "([^"]*)"$/) do |file, content|
  File.write(file, content)
end

Given(/^the file "([^"]*)" is like "([^"]*)"$/) do |target, source|
  FileUtils.cp source, target
end

# When

When(/^I run: (.+)$/) do |command|
  @stdout, @stderr, @status = Open3.capture3 command
end

When(/^I run "([^"]+)"$/) do |command|
  @stdout, @stderr, @status = Open3.capture3 command
end

# Then

Then(/^the (error )?output should (not )?be like "([^"]*)"$/) do |stderr, negate, file|
  stream = stderr ? @stderr : @stdout
  if negate
    expect(stream).to_not eq File.read(file)
  else
    expect(stream).to eq File.read(file)
  end
end

Then(/^the (error )?output should (not )?(?:contain|have|say|be|read) "([^"]*)"( exactly)?$/) do |stderr, negate, expected, exact|
  stream = stderr ? @stderr : @stdout
  if negate
    if exact
      expect(stream.strip).to_not eq expected
    else
      expect(stream).to_not match /#{expected}/im
    end
  else
    if exact
      expect(stream.strip).to eq expected
    else
      expect(stream).to match /#{expected}/im 
    end
  end
end

Then(/^the file "([^"]*)" should (not )?exist$/) do |file, negate|
  if negate
    expect(File.exist? file).to eq false
  else
    expect(File.exist? file).to eq true
  end
end

Then(/^the (?:folder|dir|directory) "([^"]*)" should (not )?exist$/) do |dir, negate|
  if negate
    expect(Dir.exist? dir).to eq false
  else
    expect(Dir.exist? dir).to eq true
  end
end

Then(/^the file "([^"]*)" should (not )?contain "([^"]*)"$/) do |file, negate, regex|
  if negate
    expect(File.read file).to_not match /#{regex}/im
  else
    expect(File.read file).to match /#{regex}/im
  end
end

