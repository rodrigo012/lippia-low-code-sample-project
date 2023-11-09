@addProject
Feature: addProject

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MWNmNmY0YTktZjdkZS00YzBiLWIyN2ItYzFiOTAwODllYzMx
    * define nombreProyecto = Tp3

  @ListWorkspace
  Scenario:
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id

  @CreateProjectAddProject
  Scenario: Create project
    Given call addProject.feature@ListWorkspace
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto}}" of key name in body addProject.json
    When execute method POST
    Then the status code should be 201


  @CreateProject400
  Scenario: Create project Bad Request
    Given call addProject.feature@ListWorkspace
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto}}" of key name in body addProject214.json
    When execute method POST
    Then the status code should be 400

  @CreateProject401
  Scenario: Create project Unauthorized
    Given call addProject.feature@ListWorkspace
    Given header x-api-key = 7562
    And base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto}}" of key name in body addProject.json
    When execute method POST
    Then the status code should be 401

  @CreateProject404
  Scenario: Create project Not Found
    Given call addProject.feature@ListWorkspace
    Given base url env.base_url_clockify
    And endpoint /v1/workspaces/{{idWorkspace}}/4356465
    And set value "{{nombreProyecto}}" of key name in body addProject.json
    When execute method POST
    Then the status code should be 404