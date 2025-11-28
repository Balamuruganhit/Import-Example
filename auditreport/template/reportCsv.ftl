<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
<#if resultList?has_content >
	<table>
		<thead>
			<tr>
				<th>Question</th>
				<th>Rating</th>
				<th>Comment</th>
				<th>Proof</th>
				<th>Approver Name</th>
			</tr>
		</thead>
		<tbody>
			<#list resultList as resultList>
				<tr>
					<td>${resultList.question!}</td>
					<td>${resultList.rating!}</td>
					<td>${resultList.comment!}</td>
					<td><image src="data:image/png;base64,${resultList.proof!}" height="250px" width="250px" content-height="scale-to-fit" /></td>
					<td>${resultList.approve!}</td>
				</tr>
			</#list>
		</tbody>
	</table>
<#else>
	<h1>No Data Record</h1>
</#if>