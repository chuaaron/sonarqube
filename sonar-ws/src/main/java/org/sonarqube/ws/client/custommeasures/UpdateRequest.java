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
package org.sonarqube.ws.client.custommeasures;

import javax.annotation.Generated;

/**
 * Update a custom measure. Value and/or description must be provided<br />Requires 'Administer System' permission or 'Administer' permission on the project.
 *
 * This is part of the internal API.
 * This is a POST request.
 * @see <a href="https://next.sonarqube.com/sonarqube/web_api/api/custom_measures/update">Further information about this action online (including a response example)</a>
 * @since 5.2
 */
@Generated("sonar-ws-generator")
public class UpdateRequest {

  private String description;
  private String id;
  private String value;

  /**
   * Example value: "Team size growing."
   */
  public UpdateRequest setDescription(String description) {
    this.description = description;
    return this;
  }

  public String getDescription() {
    return description;
  }

  /**
   * id
   *
   * This is a mandatory parameter.
   * Example value: "42"
   */
  public UpdateRequest setId(String id) {
    this.id = id;
    return this;
  }

  public String getId() {
    return id;
  }

  /**
   * Measure value. Value type depends on metric type:<ul><li>INT - type: integer</li><li>FLOAT - type: double</li><li>PERCENT - type: double</li><li>BOOL - the possible values are true or false</li><li>STRING - type: string</li><li>MILLISEC - type: integer</li><li>DATA - type: string</li><li>LEVEL - the possible values are OK, WARN, ERROR</li><li>DISTRIB - type: string</li><li>RATING - type: double</li><li>WORK_DUR - long representing the number of minutes</li></ul>
   *
   * Example value: "true"
   */
  public UpdateRequest setValue(String value) {
    this.value = value;
    return this;
  }

  public String getValue() {
    return value;
  }
}
