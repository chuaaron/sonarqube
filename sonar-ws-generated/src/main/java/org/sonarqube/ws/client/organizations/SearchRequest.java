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
package org.sonarqube.ws.client.organizations;

import java.util.List;
import javax.annotation.Generated;

/**
 * Search for organizations
 *
 * This is part of the internal API.
 * This is a POST request.
 * @see <a href="https://next.sonarqube.com/sonarqube/web_api/api/organizations/search">Further information about this action online (including a response example)</a>
 * @since 6.2
 */
@Generated("https://github.com/SonarSource/sonar-ws-generator")
public class SearchRequest {

  private String member;
  private List<String> organizations;
  private String p;
  private String ps;

  /**
   * Filter organizations based on whether the authenticated user is a member
   *
   * Possible values:
   * <ul>
   *   <li>"true"</li>
   *   <li>"false"</li>
   *   <li>"yes"</li>
   *   <li>"no"</li>
   * </ul>
   */
  public SearchRequest setMember(String member) {
    this.member = member;
    return this;
  }

  public String getMember() {
    return member;
  }

  /**
   * Comma-separated list of organization keys
   *
   * Example value: "my-org-1,foocorp"
   */
  public SearchRequest setOrganizations(List<String> organizations) {
    this.organizations = organizations;
    return this;
  }

  public List<String> getOrganizations() {
    return organizations;
  }

  /**
   * 1-based page number
   *
   * Example value: "42"
   */
  public SearchRequest setP(String p) {
    this.p = p;
    return this;
  }

  public String getP() {
    return p;
  }

  /**
   * Page size. Must be greater than 0 and less than 500
   *
   * Example value: "20"
   */
  public SearchRequest setPs(String ps) {
    this.ps = ps;
    return this;
  }

  public String getPs() {
    return ps;
  }
}
