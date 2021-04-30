# Copyright (c) 2021 SUSE LLC
# Licensed under the terms of the MIT license.

@scope_ansible
Feature: Operate an Ansible control node in a normal minion

  Scenario: Pre-requisite: Deploy test playbooks and inventory file
     Given I deploy testing playbooks and inventory files to "sle_minion"

  Scenario: Enable "Ansible control node" system type
     Given I am on the Systems overview page of this "sle_minion"
     When I follow "Properties" in the content area
     And I check "ansible_control_node"
     And I click on "Update Properties"
     Then I should see a "Ansible Control Node type has been applied." text

  Scenario: Apply highstate and check that Ansible is installed
     Given I am on the Systems overview page of this "sle_minion"
     When I follow "States" in the content area
     And I click on "Apply Highstate"
     And I wait until event "Apply highstate scheduled by admin" is completed
     Then "ansible" should be installed on "sle_minion"

  Scenario: The Ansible tab appears in the system overview page
     Given I am on the Systems overview page of this "sle_minion"
     When I follow "Ansible" in the content area
     Then I should see a "Ansible Control Node Configuration" text

  Scenario: Configure some inventory and playbooks path
     Given I am on the Systems overview page of this "sle_minion"
     When I follow "Ansible" in the content area
     Then I should see a "Ansible Control Node Configuration" text
     And I enter "/srv/playbooks/" as "new_playbook_path_input"
     And I click on button with id "new_playbook_path_save"
     And I enter "/srv/playbooks/example_playbook2_orion_dummy/hosts" as "new_inventory_path_input"
     And I click on button with id "new_inventory_path_save"

  Scenario: Display inventories
     Given I am on the Systems overview page of this "sle_minion"
     When I follow "Ansible" in the content area
     And I follow "Inventories" in the content area
     And I wait until I see "/srv/playbooks/example_playbook2_orion_dummy/hosts" text
     Then I click on "/srv/playbooks/example_playbook2_orion_dummy/hosts"
     And I should see "myself" text

  Scenario: Discover playbooks and display them
     Given I am on the Systems overview page of this "sle_minion"
     When I follow "Ansible" in the content area
     And I follow "Playbooks" in the content area
     And I wait until I see "/srv/playbooks/" text
     And I click on "/srv/playbooks/"
     Then I wait until I see "Fullpath: /srv/playbooks/example_playbook2_orion_dummy/example_playbook2_orion_dummy.yml" text

  Scenario: Run a playbook using custom inventory
     Given I am on the Systems overview page of this "sle_minion"
     When I follow "Ansible" in the content area
     And I follow "Playbooks" in the content area
     And I wait until I see "/srv/playbooks/" text
     And I click on "/srv/playbooks/"
     And I wait until I see "Fullpath: /srv/playbooks/example_playbook2_orion_dummy/example_playbook2_orion_dummy.yml" text
     Then I follow "/srv/playbooks/example_playbook2_orion_dummy/example_playbook2_orion_dummy.yml" in the content area
     And I click on "Run playbook"
     And I should see a "Playbook execution triggered" text
     And I wait until event "Run playbook scheduled by admin" is completed
     And file "/tmp/example_file.txt" should exist on "ssh_minion"

  Scenario: Cleanup: Disable Ansible and remove test playbooks and inventory file
     Given I am on the Systems overview page of this "sle_minion"
     When I follow "Properties" in the content area
     And I uncheck "ansible_control_node"
     And I click on "Update Properties"
     Then I should see a "System properties changed" text
     And I apply highstate on "ssh_minion"
     And "ansible" should be installed on "ssh_minion"
     And I remove testing playbooks and inventory files from "ssh_minion"
     And I remove "/tmp/example_file.txt" from "ssh_minion"
