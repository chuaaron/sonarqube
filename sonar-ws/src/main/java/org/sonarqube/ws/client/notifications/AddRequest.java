/*
 * SonarQube
 * Copyright (C) 2009-2017 SonarSource SA
 * mailto:info AT sonarsource DOT com
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
package org.sonarqube.ws.client.notifications;

import javax.annotation.Generated;

/**
 * Add a notification for the authenticated user.<br>Requires one of the following permissions:<ul> <li>Authentication if no login is provided. If a project is provided, requires the 'Browse' permission on the specified project.</li> <li>System administration if a login is provided. If a project is provided, requires the 'Browse' permission on the specified project.</li></ul>
 *
 * This is part of the internal API.
 * This is a POST request.
 * @see <a href="https://next.sonarqube.com/sonarqube/web_api/api/notifications/add">Further information about this action online (including a response example)</a>
 * @since 6.3
 */
@Generated("sonar-ws-generator")
public class AddRequest {

  private String channel;
  private String login;
  private String project;
  private String type;

  /**
   * Channel through which the notification is sent. For example, notifications can be sent by email.
   *
   * Possible values:
   * <ul>
   *   <li>"EmailNotificationChannel"</li>
   * </ul>
   */
  public AddRequest setChannel(String channel) {
    this.channel = channel;
    return this;
  }

  public String getChannel() {
    return channel;
  }

  /**
   * User login
   *
   */
  public AddRequest setLogin(String login) {
    this.login = login;
    return this;
  }

  public String getLogin() {
    return login;
  }

  /**
   * Project key
   *
   * Example value: "my_project"
   */
  public AddRequest setProject(String project) {
    this.project = project;
    return this;
  }

  public String getProject() {
    return project;
  }

  /**
   * Notification type. Possible values are for:<ul>  <li>Global notifications: CeReportTaskFailure, ChangesOnMyIssue, NewAlerts, NewFalsePositiveIssue, NewIssues, SQ-MyNewIssues</li>  <li>Per project notifications: CeReportTaskFailure, ChangesOnMyIssue, NewAlerts, NewFalsePositiveIssue, NewIssues, SQ-MyNewIssues</li></ul>
   *
   * This is a mandatory parameter.
   * Example value: "SQ-MyNewIssues"
   */
  public AddRequest setType(String type) {
    this.type = type;
    return this;
  }

  public String getType() {
    return type;
  }
}
