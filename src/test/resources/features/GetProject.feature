@Workspaces
Feature: getProjects

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MWNmNmY0YTktZjdkZS00YzBiLWIyN2ItYzFiOTAwODllYzMx

  @getWorkspacesGetProject
  Scenario: Get all workspaces
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id

  @ListProjectsGetProject
  Scenario: get all projects
    Given call GetProject.feature@getWorkspacesGetProject
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200

  @ListProjectsGetProject400
  Scenario: get all projects Bad request
    Given call GetProject.feature@ListProjectsGetProject
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/xasdf
    When execute method GET
    Then the status code should be 400

  @ListProjectsGetProject401
  Scenario: get all projects Unauthorised
    Given call GetProject.feature@ListProjectsGetProject
    And header x-api-key = 33
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 401

  @ListProjectsGetProject404
  Scenario: get all projects Not found
    Given call GetProject.feature@ListProjectsGetProject
    And base url env.base_url_clockify
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects514
    When execute method GET
    Then the status code should be 404