# Copyright (c) 2010-2011 Novell, Inc.
# Licensed under the terms of the MIT license.

Given /^I am on the errata page$/ do
  step "I am authorized"
  within(:xpath, "//header") do
    find_link(debrand_string("Errata")).click
  end
end

Given /^I am on the "([^"]*)" errata Details page$/ do |arg1|
  step "I am on the errata page"
    step "I follow \"All\" in the left menu"
    step "I follow \"#{arg1}\""
end

Then /^I should see three links to the errata in the list$/ do
  arch=`uname -m`
  arch.chomp!
  linknames = [ "slessp2-nfs-client-6222",
		"slessp2-aaa_base-6544"]
  if arch != "x86_64"
      linknames << "slessp2-kernel-6641"
  else
      linknames << "slessp2-kernel-6648"
  end
  linknames.each() do |link|
    fail if not has_xpath?("//form/table/tbody/tr/td/a[contains(.,'#{link}')]")
  end
end

Then /^I should see an update in the list$/ do
  fail if not has_xpath?("//form/div/div/div/table/tbody/tr/td/a")
end
