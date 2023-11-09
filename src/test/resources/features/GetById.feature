Feature: GetById

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MWNmNmY0YTktZjdkZS00YzBiLWIyN2ItYzFiOTAwODllYzMx
    And base url env.base_url_clockify

  @ListWorkspaceGetId
  Scenario: Get all workspaces
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id

  @ListProjectsGetById
  Scenario: get all projects
    Given call GetById.feature@ListWorkspaceGetId
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    * define idProject = $[0].id

  @GetId
  Scenario: get project by id
    Given call GetById.feature@ListProjectsGetById
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    When execute method GET
    Then the status code should be 200

  @GetId400
  Scenario: get project Bad Request
    Given call GetById.feature@ListWorkspaceGetId
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/013ty9p1
    When execute method GET
    Then the status code should be 400

  @GetId401
  Scenario: get project Unauthorised
    Given header x-api-key = MNmNmY0YTktZjdkZS00YzBiLWIyN2ItYzFiOTAwODllYzMx
    And call GetById.feature@ListProjectsGetById
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    When execute method GET
    Then the status code should be 401

  @GetId404
  Scenario: get project by id Not Found
    Given call GetById.feature@ListWorkspaceGetId
    And endpoint /v1/workspaces/{{idWorkspace}}/projects6/6321345
    When execute method GET
    Then the status code should be 404


