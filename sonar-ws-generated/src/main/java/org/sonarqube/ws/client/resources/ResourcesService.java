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
package org.sonarqube.ws.client.resources;

import java.util.stream.Collectors;
import javax.annotation.Generated;
import org.sonarqube.ws.MediaTypes;
import org.sonarqube.ws.client.BaseService;
import org.sonarqube.ws.client.GetRequest;
import org.sonarqube.ws.client.PostRequest;
import org.sonarqube.ws.client.WsConnector;

/**
 * Removed since 6.3, please use api/components and api/measures instead
 * @see <a href="https://next.sonarqube.com/sonarqube/web_api/api/resources">Further information about this web service online</a>
 */
@Generated("sonar-ws-generator")
public class ResourcesService extends BaseService {

  public ResourcesService(WsConnector wsConnector) {
    super(wsConnector, "api/resources");
  }

  /**
   * The web service is removed and you're invited to use the alternatives: <ul><li>if you need one component without measures: api/components/show</li><li>if you need one component with measures: api/measures/component</li><li>if you need several components without measures: api/components/tree</li><li>if you need several components with measures: api/measures/component_tree</li></ul>
   *
   * This is part of the internal API.
   * This is a GET request.
   * @see <a href="https://next.sonarqube.com/sonarqube/web_api/api/resources/index">Further information about this action online (including a response example)</a>
   * @since 2.10
   * @deprecated since 5.4
   */
  @Deprecated
  public String index() {
    return call(
      new GetRequest(path("index"))
        .setMediaType(MediaTypes.JSON)
      ).content();
  }
}
