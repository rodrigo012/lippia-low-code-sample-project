Feature: Update Projects

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MWNmNmY0YTktZjdkZS00YzBiLWIyN2ItYzFiOTAwODllYzMx
    And base url env.base_url_clockify
    * define nombreProyectoUpdate = ProjectUpdate

  @ListWorkspaceUpdateProjects
  Scenario: Get all workspaces
    Given base url env.base_url_clockify
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $[0].id


  @CreateProjectUpdate
  Scenario: Create project for update
    Given call UpdateProjects.feature@ListWorkspaceUpdateProjects
    And endpoint v1/workspaces/{{idWorkspace}}/projects
    And set value "{{nombreProyectoUpdate}}" of key name in body addProjectUpdate.json
    When execute method POST
    Then the status code should be 201
    * define idProject = $.id

  @UpdateProject
  Scenario: Update Project
    Given call UpdateProjects.feature@CreateProjectUpdate
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProject}}
    And set value "true" of key archived in body UpdateProjectArchive.json
    When execute method PUT
    Then the status code should be 200

  @UpdateProject400
  Scenario: Update Project Bad Request
    Given call UpdateProjects.feature@ListWorkspaceUpdateProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/hhqwehjjj3
    And set value "true" of key archived in body UpdateProjectArchive.json
    When execute method PUT
    Then the status code should be 400

  @UpdateProject401
  Scenario: Update Project Unauthorised
    Given header x-api-key = adfq2w
    And call UpdateProjects.feature@ListWorkspaceUpdateProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects/65442c15894cb47ead025aab
    And set value "true" of key archived in body UpdateProjectArchive.json
    When execute method PUT
    Then the status code should be 401

  @UpdateProject404
  Scenario: Update Project Not Found
    Given call UpdateProjects.feature@ListWorkspaceUpdateProjects
    And endpoint /v1/workspaces/{{idWorkspace}}/projects1234/11324rv1vr1v23ads
    And set value "true" of key archived in body UpdateProjectArchive.json
    When execute method PUT
    Then the status code should be 404