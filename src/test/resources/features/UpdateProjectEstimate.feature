Feature: updateProjectEstimate

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MWNmNmY0YTktZjdkZS00YzBiLWIyN2ItYzFiOTAwODllYzMx
    And base url env.base_url_clockify
    * define nombreProyecto = ProjectUpdateEstimate

  @ListWorkspaceEst
  Scenario:
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id


  @CreateProjectEst
  Scenario: Create Proyecto
    Given call UpdateProject.feature@ListWorkspace
    And endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyecto}}" of key name in body addProjectUpdate.json
    When execute method POST
    Then the status code should be 201
    * define idProject = $.id

  @UpdateEst
  Scenario: Update  project
    Given call UpdateProject.feature@CreateProjectEst
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And set value "MANUAL" of key type in body Update.json
    When execute method PATCH
    Then the status code should be 200

  @UpdateEst400
  Scenario:  Project Bad Request
    Given call UpdateProject.feature@ListWorkspaceEst
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/$$$$/
    And set value "MANUAL" of key type in body Update.json
    When execute method PATCH
    Then the status code should be 400

  @UpdateEst401
  Scenario:  Project Unauthorized
    Given header x-api-key = 8tg67
    And call UpdateProject.feature@ListWorkspaceEst
    And endpoint /v1/workspaces/{{idWorkspace}}/projects2/ads
    When execute method PATCH
    Then the status code should be 401

  @UpdateEst404
  Scenario:  Project Not Found
    Given call UpdateProject.feature@ListWorkspaceEst
    And endpoint /v1/workspaces/{{idWorkspace}}/project5s/asd
    When execute method PATCH
    Then the status code should be 404