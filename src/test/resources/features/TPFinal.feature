@All
Feature: Clockify TP Final

  Background:

    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MWNmNmY0YTktZjdkZS00YzBiLWIyN2ItYzFiOTAwODllYzMx

  @ListWorkspace
  Scenario: Get all my workspaces
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[0].id

  @ListProject
  Scenario: Get all projects on workspace
    Given call TPFinal.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/65381f09671f3c6ed98076da/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id
    * define userId = $.[0].memberships.[0].userId


  @ListTimeEntries
  Scenario: Get time entries for a user on workspace
    Given call TPFinal.feature@ListWorkspace
    And call TPFinal.feature@ListProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/65381f09671f3c6ed98076da/user/65381f09671f3c6ed98076d8/time-entries
    When execute method GET
    Then the status code should be 200


  @AddProjectHours
  Scenario: Add time entry to a project
    Given call TPFinal.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/65381f09671f3c6ed98076da/time-entries
    And body addTimeEntry.json
    When execute method POST

  @UpdateTimeEntry
  Scenario: Update time entry on workspace
    Given call TPFinal.feature@ListWorkspace
    And call TPFinal.feature@AddProjectHours
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/65381f09671f3c6ed98076da/time-entries/65397dba69c58c7c9b2dd365
    And body TimeEntry.json
    When execute method PUT

  @DeleteTimeEntry
  Scenario: Delete time entry from workspace
    Given call TPFinal.feature@ListWorkspace
    And call TPFinal.feature@@AddTimeEntry
    And endpoint /v1/workspaces/65381f09671f3c6ed98076da/time-entries/{{idTime}}
    When execute method DELETE