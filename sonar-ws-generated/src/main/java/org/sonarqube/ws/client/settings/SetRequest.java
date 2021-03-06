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
package org.sonarqube.ws.client.settings;

import java.util.List;
import javax.annotation.Generated;

/**
 * Update a setting value.<br>Either 'value' or 'values' must be provided.<br> Requires one of the following permissions: <ul><li>'Administer System'</li><li>'Administer' rights on the specified component</li></ul>
 *
 * This is part of the internal API.
 * This is a POST request.
 * @see <a href="https://next.sonarqube.com/sonarqube/web_api/api/settings/set">Further information about this action online (including a response example)</a>
 * @since 6.1
 */
@Generated("https://github.com/SonarSource/sonar-ws-generator")
public class SetRequest {

  private String branch;
  private String component;
  private String fieldValues;
  private String key;
  private String value;
  private String values;

  /**
   * Branch key. Only available on following settings : sonar.leak.period
   *
   * This is part of the internal API.
   * Example value: "feature/my_branch"
   */
  public SetRequest setBranch(String branch) {
    this.branch = branch;
    return this;
  }

  public String getBranch() {
    return branch;
  }

  /**
   * Component key
   *
   * Example value: "my_project"
   */
  public SetRequest setComponent(String component) {
    this.component = component;
    return this;
  }

  public String getComponent() {
    return component;
  }

  /**
   * Setting field values. To set several values, the parameter must be called once for each value.
   *
   * Example value: "fieldValues={\"firstField\":\"first value\", \"secondField\":\"second value\", \"thirdField\":\"third value\"}"
   */
  public SetRequest setFieldValues(String fieldValues) {
    this.fieldValues = fieldValues;
    return this;
  }

  public String getFieldValues() {
    return fieldValues;
  }

  /**
   * Setting key
   *
   * This is a mandatory parameter.
   * Example value: "sonar.links.scm"
   */
  public SetRequest setKey(String key) {
    this.key = key;
    return this;
  }

  public String getKey() {
    return key;
  }

  /**
   * Setting value. To reset a value, please use the reset web service.
   *
   * Example value: "git@github.com:SonarSource/sonarqube.git"
   */
  public SetRequest setValue(String value) {
    this.value = value;
    return this;
  }

  public String getValue() {
    return value;
  }

  /**
   * Setting multi value. To set several values, the parameter must be called once for each value.
   *
   * Example value: "values=firstValue&values=secondValue&values=thirdValue"
   */
  public SetRequest setValues(String values) {
    this.values = values;
    return this;
  }

  public String getValues() {
    return values;
  }
}
