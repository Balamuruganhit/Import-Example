<!-- =============================
     TOP NAV BUTTONS
============================= -->
<div style="width: 95%; margin: 20px auto; display: flex; justify-content: center; gap: 12px;">
    <button class="topbar-btn active" data-target="allCharts">ALL</button>
    <button class="topbar-btn" data-target="prodChartDiv">Production Vs Actual</button>
    <button class="topbar-btn" data-target="monthlyChartDiv">In-House Rework vs Rejected</button>
    <button class="topbar-btn" data-target="salesPieChartDiv">Sales TurnOver Monthly</button>
    <button class="topbar-btn" data-target="shipmentChartDiv">Scheduled vs Delivery</button>
    <button class="topbar-btn" data-target="complaintChartDiv">Customer Complaints</button>
    <button class="topbar-btn" data-target="invoiceChartDiv">Total Sales Invoice Received Monthly</button>
</div>

<!-- =============================
     WRAP EACH CHART IN A DIV
============================= -->
<div id="allCharts">

    <div id="prodChartDiv">
        
<#assign userLogin = sessionAttributes.userLogin>
<#assign ctx = Static["org.apache.ofbiz.base.util.UtilMisc"].toMap("userLogin", userLogin)>
<#assign result = dispatcher.runSync("ListQuantityProducedData", ctx)!{} >
<#assign workEffortList = result.workEffortList![] >

<#if workEffortList?has_content>
<div style="width:80%; margin:auto; margin-top:35px; background:white; padding:18px; border-radius:12px; box-shadow:0 2px 6px rgba(0,0,0,0.15);">
    <h3 style="text-align:center; color:#004aad;">Planned vs Actual Productions</h3>

    <!-- Search -->
    <div style="margin-bottom:10px;">
        <input type="text" id="searchBox" placeholder="Search Product ID..." style="width:40%; padding:6px;">
    </div>

    <!-- Items per page + Goto -->
    <div style="display:flex; justify-content:space-between; margin-bottom:10px;">
        <label>
            Items per page:
            <select id="itemsPerPage">
                <option value="5">5</option>
                <option value="10" selected>10</option>
                <option value="20">20</option>
            </select>
        </label>
        <label>
            Go to page:
            <input type="number" id="gotoPage" min="1" style="width:60px;" />
            <button id="gotoBtn">Go</button>
        </label>
    </div>

    <canvas id="prodChart" height="150"></canvas>

    <!-- Pagination -->
    <div style="text-align:center; margin-top:10px;">
        <button id="firstBtn">First</button>
        <button id="prevBtn">Previous</button>
        <span id="pageNumbers"></span>
        <button id="nextBtn">Next</button>
        <button id="lastBtn">Last</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
document.addEventListener("DOMContentLoaded", () => {

    // Arrays from service
    const baseLabels = [ <#list workEffortList as we>"${we.productName}"<#if we_has_next>,</#if></#list> ];
    const basePlanned = [ <#list workEffortList as we>${we.quantityPlanned}<#if we_has_next>,</#if></#list> ];
    const baseActual  = [ <#list workEffortList as we>${we.quantityActual}<#if we_has_next>,</#if></#list> ];
    const baseProductIds = [ <#list workEffortList as we>"${we.productId}"<#if we_has_next>,</#if></#list> ]; // For search

    let labels = [...baseLabels];
    let plannedData = [...basePlanned];
    let actualData = [...baseActual];

    let currentPage = 1;
    let itemsPerPage = parseInt(document.getElementById("itemsPerPage").value);

    const ctx = document.getElementById("prodChart");
    let chart = new Chart(ctx, { type: "bar", data: { labels: [], datasets: [] } });

    function getTotalPages() {
        return Math.ceil(labels.length / itemsPerPage);
    }

    function renderChart(page) {
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;

        chart.data.labels = labels.slice(start, end);
        chart.data.datasets = [
            { label: "Planned", data: plannedData.slice(start, end), backgroundColor: "#14a7c2ff" },
            { label: "Actual",  data: actualData.slice(start, end),  backgroundColor: "#004d61ff" }
        ];
        chart.update();
        renderPageButtons();
    }

    function renderPageButtons() {
        const container = document.getElementById("pageNumbers");
        container.innerHTML = "";

        for (let i = 1; i <= getTotalPages(); i++) {
            const btn = document.createElement("button");
            btn.textContent = i;
            btn.style.margin = "0 4px";
            if (i === currentPage) {
                btn.style.background = "#004aad";
                btn.style.color = "white";
                btn.style.fontWeight = "bold";
            }
            btn.onclick = () => { currentPage = i; renderChart(i); };
            container.appendChild(btn);
        }
    }

    // Pagination buttons
    document.getElementById("prevBtn").onclick = () => { if (currentPage > 1) { currentPage--; renderChart(currentPage); } };
    document.getElementById("nextBtn").onclick = () => { if (currentPage < getTotalPages()) { currentPage++; renderChart(currentPage); } };
    document.getElementById("firstBtn").onclick = () => { currentPage = 1; renderChart(currentPage); };
    document.getElementById("lastBtn").onclick = () => { currentPage = getTotalPages(); renderChart(currentPage); };

    document.getElementById("itemsPerPage").onchange = (e) => {
        itemsPerPage = parseInt(e.target.value);
        currentPage = 1;
        renderChart(currentPage);
    };

    document.getElementById("gotoBtn").onclick = () => {
        const page = parseInt(document.getElementById("gotoPage").value);
        if (page >= 1 && page <= getTotalPages()) {
            currentPage = page;
            renderChart(page);
        }
    };

    // Search filter by Product ID
    document.getElementById("searchBox").addEventListener("keyup", (event) => {
        const q = event.target.value.toLowerCase();
        labels = [];
        plannedData = [];
        actualData = [];

        baseProductIds.forEach((pid, i) => {
            if (pid.toLowerCase().includes(q)) {
                labels.push(baseLabels[i]); // show productName on X-axis
                plannedData.push(basePlanned[i]);
                actualData.push(baseActual[i]);
            }
        });

        currentPage = 1;
        renderChart(currentPage);
    });

    renderChart(currentPage);
});
</script>

<#else>
<div style="margin-top:20px; font-size:16px; color:red;">No production data found.</div>
</#if>

    </div>

    <div id="monthlyChartDiv">
     <#-- Call second service -->
<#assign allMonths = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]>

<#assign ctx2 = Static["org.apache.ofbiz.base.util.UtilMisc"].toMap("userLogin", userLogin)>
<#assign result2 = dispatcher.runSync("ListMonthlyReworkRejectedStats", ctx2)!{} >
<#assign monthlyList = result2.monthlyReworkRejectedStats![] />

<#-- If service returns null values, convert to 0 -->
<#assign monthlyList = result2.monthlyReworkRejectedStats!
    (result2.monthlyStats!
    (result2.statsList![])) />

<div style="width:80%; margin:auto; margin-top:35px; background:white; padding:18px; border-radius:12px; box-shadow:0 2px 6px rgba(0,0,0,0.15);">
    <h3 style="text-align:center; color:#c42200;">Monthly In-House Rework vs Rejected</h3>
    <canvas id="monthlyChart" height="160"></canvas>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {

        const monthlyLabels = [
        <#list allMonths as month>
            "${month}"<#if month_has_next>,</#if>
        </#list>
    ];


    const monthlyRework = [
    <#list monthlyList as m>
        ${(m.reworkCount!m.rework)!0}<#if m_has_next>,</#if>
    </#list>
    ];

    const monthlyRejected = [
    <#list monthlyList as m>
        ${(m.rejectedCount!m.rejected)!0}<#if m_has_next>,</#if>
    </#list>
    ];

    if (monthlyLabels.length === 0) {
        document.getElementById("monthlyChart").outerHTML =
            "<div style='color:red; text-align:center; margin-top:10px;'>No monthly rework / rejected statistics found.</div>";
        return;
    }

    new Chart(document.getElementById("monthlyChart"), {
        type: "bar",
        data: {
            labels: monthlyLabels,
            datasets: [
                { label: "Rework", data: monthlyRework, backgroundColor: "#f0a400" },
                { label: "Rejected", data: monthlyRejected, backgroundColor: "#d43f00" }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                tooltip: {
                    callbacks: {
                        title: function(context) {
                            // Show month name in tooltip
                            return context[0].label;
                        },
                        label: function(context) {
                            return context.dataset.label + ": " + context.raw;
                        }
                    }
                }
            },
            scales: {
                x: {
                    ticks: {
                        autoSkip: false,
                        maxRotation: 45,
                        minRotation: 0
                    }
                },
                y: {
                    beginAtZero: true
                }
            }
        }
    });
});
</script>
    </div>

    <div id="salesPieChartDiv">
 
      
<#assign userLogin = sessionAttributes.userLogin>
<#assign ctx = {"userLogin": userLogin}>

<#-- LOAD SERVICE DATA -->
<#assign result = dispatcher.runSync("ListMonthlySalesOrderTotals", ctx)!{} >
<#assign monthList = result.monthlySalesTotalList![] >

<#-- CLEAN MONTH NAMES -->
<#assign normalizedList = [] />
<#list monthList as item>
    <#assign cleanMonth = item.month?substring(item.month?length - 3, item.month?length) />
    <#assign normalizedList = normalizedList + [{
        "month": cleanMonth,
        "year": item.year?default("2025"),
        "totalAmount": item.totalAmount,
        "orderCount": item.orderCount
    }] />
</#list>

<#-- FIXED 12 MONTH TEMPLATE -->
<#assign defaultMonths = {
    "Jan":{"month":"Jan","totalAmount":0,"orderCount":0},
    "Feb":{"month":"Feb","totalAmount":0,"orderCount":0},
    "Mar":{"month":"Mar","totalAmount":0,"orderCount":0},
    "Apr":{"month":"Apr","totalAmount":0,"orderCount":0},
    "May":{"month":"May","totalAmount":0,"orderCount":0},
    "Jun":{"month":"Jun","totalAmount":0,"orderCount":0},
    "Jul":{"month":"Jul","totalAmount":0,"orderCount":0},
    "Aug":{"month":"Aug","totalAmount":0,"orderCount":0},
    "Sep":{"month":"Sep","totalAmount":0,"orderCount":0},
    "Oct":{"month":"Oct","totalAmount":0,"orderCount":0},
    "Nov":{"month":"Nov","totalAmount":0,"orderCount":0},
    "Dec":{"month":"Dec","totalAmount":0,"orderCount":0}
} />

<#-- MERGE YEARS -->
<#list normalizedList as item>
    <#assign defaultMonths = defaultMonths + {
        item.month: {
            "month": item.month,
            "totalAmount": item.totalAmount,
            "orderCount": item.orderCount,
            "year": item.year
        }
    } >
</#list>

<#-- DYNAMIC YEAR VALUES -->
<#assign currentYear = .now?string("yyyy")?number />
<#assign year2 = currentYear - 1 />
<#assign year1 = currentYear />

<style>
    .chart-container-monthly {
        width: 93%;
        margin: 30px auto;
        padding: 20px;
        text-align: center;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    #salesMonthlyChart {
        max-height: 360px;
        height: 360px !important; /* prevents stretching */
    }
</style>

<div class="chart-container-monthly">
    <h2>Monthly Sales Order Amount</h2>

    <select id="yearSelector">
        <option value="${year1}" selected>${year1}</option>
        <option value="${year2}">${year2}</option>
    </select>

    <canvas id="salesMonthlyChart"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
let chartRef = null;

// LOAD DATA
const allMonthsData = {
    <#list defaultMonths?values as m>
        "${m.month}": {
            totalAmount: ${m.totalAmount},
            orderCount: ${m.orderCount},
            year: "${m.year?default(currentYear?string)}"
        }<#if m_has_next>,</#if>
    </#list>
};

function loadChart(selectedYear) {

    const labels = [];
    const dataAmounts = [];
    const dataOrderCounts = [];

    for (const monthName in allMonthsData) {
        const m = allMonthsData[monthName];
        if (m.year != selectedYear) continue;

        labels.push(monthName);
        dataAmounts.push(m.totalAmount);
        dataOrderCounts.push(m.orderCount);
    }

    if (chartRef) chartRef.destroy();

    const ctx = document.getElementById('salesMonthlyChart').getContext('2d');

    chartRef = new Chart(ctx, {
        type: 'bar',
        data: {
            labels,
            datasets: [{
                label: "Total Amount (INR)",
                data: dataAmounts,
                backgroundColor: 'rgba(118, 32, 155, 0.7)',
                borderColor: 'rgba(88, 28, 116, 1)',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false, // prevents affecting other charts
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const amount = context.raw.toLocaleString("en-IN");
                            return "(INR)" + amount + " | Orders: " + dataOrderCounts[context.dataIndex];
                        }
                    }
                }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
}

// INITIAL RENDER
loadChart("${year1}");

// YEAR CHANGE EVENT
document.getElementById("yearSelector").addEventListener("change", function() {
    loadChart(this.value);
});
</script>
    </div>
    <div id="shipmentChartDiv">
  

<#assign userLogin = sessionAttributes.userLogin>
<#assign ctx = Static["org.apache.ofbiz.base.util.UtilMisc"].toMap("userLogin", userLogin)>
<#assign result = dispatcher.runSync("ListShipmentData", ctx)!{} >
<#assign shipmentList = result.shipmentList![]>

<#if shipmentList?has_content>

    <#assign onTimeCount = 0>
    <#assign lateCount = 0>
    <#assign deliveredCount = 0>   <#-- NEW: total actual deliveries -->

    <#list shipmentList as shipment>

        <#assign actualStr   = (shipment.lastUpdatedStamp!"")?string >
        <#assign estimateStr = (shipment.estimatedDeliveryDate!"")?string >

        <#-- Count shipments having a valid Actual Delivery -->
        <#if actualStr?trim != "" && actualStr != "N/A">
            <#assign deliveredCount = deliveredCount + 1>
        </#if>

        <#-- Skip if either date is empty or N/A -->
        <#if actualStr?trim == "" || actualStr == "N/A" ||
             estimateStr?trim == "" || estimateStr == "N/A">
            <#continue>
        </#if>

        <#assign actual   = "" >
        <#assign estimate = "" >

        <#-- Only parse valid formats -->
        <#if actualStr?has_content && actualStr != "N/A" && actualStr?matches("^[0-9]{4}-[0-9]{2}-[0-9]{2}.*")>
            <#assign actual = actualStr?datetime("yyyy-MM-dd HH:mm:ss") >
        </#if>

        <#if estimateStr?has_content && estimateStr != "N/A" && estimateStr?matches("^[0-9]{4}-[0-9]{2}-[0-9]{2}.*")>
            <#assign estimate = estimateStr?datetime("yyyy-MM-dd HH:mm:ss") >
        </#if>

        <#-- Count only valid parsed dates -->
        <#if actual?is_date && estimate?is_date>
            <#if actual <= estimate>
                <#assign onTimeCount = onTimeCount + 1>
            <#else>
                <#assign lateCount = lateCount + 1>
            </#if>
        </#if>

    </#list>

    <#assign totalShipments = onTimeCount + lateCount >

    <#if totalShipments == 0>
        <#assign onTimePercent = 0>
        <#assign latePercent = 0>
    <#else>
        <#assign onTimePercent = (onTimeCount * 100.0) / totalShipments >
        <#assign latePercent  = (lateCount * 100.0) / totalShipments >
    </#if>


    <!-- ============================
         MAIN ON-TIME / LATE BOX
         ============================ -->
    <div style="
        width: 90%; 
        margin: 30px auto; 
        background: #ffffff;
        padding: 20px; 
        border-radius: 12px; 
        box-shadow: 0 3px 10px rgba(0,0,0,0.15);
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-family: 'Poppins', sans-serif;
    ">

        <!-- LEFT SIDE -->
        <div style="width: 50%; text-align: center;">
            <h3 style="margin: 0; color: #28a745;">On-Time Deliveries</h3>
            <p style="font-size: 26px; font-weight: 700; color: #28a745; margin: 5px 0;">
                ${onTimePercent?string("0.00")}% 
            </p>
            <p style="font-size: 14px; color: #555;">
                (${onTimeCount} of ${totalShipments})
            </p>
        </div>

        <div style="width: 2px; height: 70px; background: #d3d3d3; border-radius: 5px;"></div>

        <!-- RIGHT SIDE -->
        <div style="width: 50%; text-align: center;">
            <h3 style="margin: 0; color: #dc3545;">Late Deliveries</h3>
            <p style="font-size: 26px; font-weight: 700; color: #dc3545; margin: 5px 0;">
                ${latePercent?string("0.00")}% 
            </p>
            <p style="font-size: 14px; color: #555;">
                (${lateCount} of ${totalShipments})
            </p>
        </div>

    </div>


    <!-- ============================
         NEW BOX: TOTAL DELIVERED
         ============================ -->
    <div style="
        width: 90%; 
        margin: 10px auto; 
        background: #f8f9fa;
        padding: 20px; 
        border-radius: 12px; 
        box-shadow: 0 2px 8px rgba(0,0,0,0.10);
        font-family: 'Poppins', sans-serif;
        text-align: center;
    ">
        <h3 style="margin: 0; color: #007bff;">Total Delivered Orders</h3>

        <p style="font-size: 26px; font-weight: 700; color: #007bff; margin: 10px 0;">
            ${deliveredCount}
        </p>
    </div>


<#else>

    <div style="text-align:center;margin-top:20px;color:#777;">
        No shipment data found.
    </div>

</#if>

<#if shipmentList?has_content>
<div style="width: 90%; margin: auto; margin-top: 30px; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <h2 style="text-align:center;">Scheduled Vs Delivered</h2>
    <canvas id="shipmentChart"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
const labels = [
    <#list shipmentList as shipment>
        "${shipment.primaryOrderId!''}"<#if shipment_has_next>,</#if>
    </#list>
];

const lastUpdatedData = [
    <#list shipmentList as shipment>
        <#if shipment.lastUpdatedStamp?has_content && shipment.lastUpdatedStamp != "N/A">
            "${shipment.lastUpdatedStamp}"
        <#else>
            null
        </#if>
        <#if shipment_has_next>,</#if>
    </#list>
];

const estimatedDeliveryData = [
    <#list shipmentList as shipment>
        <#if shipment.estimatedDeliveryDate?has_content && shipment.estimatedDeliveryDate != "N/A">
            "${shipment.estimatedDeliveryDate}"
        <#else>
            null
        </#if>
        <#if shipment_has_next>,</#if>
    </#list>
];

// Convert strings to timestamps in JS
const parseDate = str => {
    const d = new Date(str);
    return (str && !isNaN(d.getTime())) ? d.getTime() : null;
};

const lastUpdatedTimestamps = lastUpdatedData.map(parseDate);
const estimatedDeliveryTimestamps = estimatedDeliveryData.map(parseDate);

// Function to dynamically set bar color for Actual Delivery Date
const actualDeliveryColors = lastUpdatedTimestamps.map((val, index) => {
    const estimated = estimatedDeliveryTimestamps[index];
    if (val && estimated) {
        if (val < estimated) return 'rgba(0, 200, 0, 0.7)'; // green before estimated
        else if (val === estimated) return 'rgba(54, 162, 235, 0.6)'; // blue equal
        else return 'rgba(255, 0, 0, 0.7)'; // red if after estimated
    }
    return 'rgba(54, 162, 235, 0.6)'; // default blue
});

const ctx = document.getElementById('shipmentChart').getContext('2d');
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [
            {
                label: 'Actual Delivery Date',
                data: lastUpdatedTimestamps,
                backgroundColor: actualDeliveryColors
            },
            {
                label: 'Estimated Delivery Date',
                data: estimatedDeliveryTimestamps,
                backgroundColor: 'rgba(255, 99, 132, 0.6)'
            }
        ]
    },
    options: {
        indexAxis: 'y',  // horizontal bars
        responsive: true,
        plugins: {
            tooltip: {
                callbacks: {
                    label: function(context) {
                        const orderId = context.label || 'N/A'; // y-axis label
                        const dateValue = context.raw ? new Date(context.raw).toLocaleString() : 'N/A';
                        return orderId + ' - ' + context.dataset.label + ': ' + dateValue;
                    }
                }
            }
        },
        scales: {
            x: {
                title: { display: true, text: 'Date & Time' },
                ticks: {
                    callback: value => value ? new Date(value).toLocaleDateString() : ''
                }
            },
            y: { title: { display: true, text: 'Primary Order ID' } }
        }
    }
});
</script>

<#else>
<div style="text-align:center; margin-top:50px;">
    <p>No shipment data found.</p>
</div>
</#if>
    </div>
 <div id="complaintChartDiv">
        
<#-- ============================= -->
<#-- CALL CountFracasComplaints SERVICE -->
<#-- ============================= -->
<#assign serviceResult = dispatcher.runSync("CountFracasComplaints", {
    "userLogin": userLogin
}) />

<#assign totalComplaints = serviceResult.totalComplaints!0 />

<!-- ============================= -->
<!--  DASHBOARD STYLE CHART CARD   -->
<!-- ============================= -->
<div style="
    width: 650px;
    margin: 40px auto;
    background: #ffffff;
    border-radius: 20px;
    padding: 25px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
">

    <!-- TITLE -->
    <h3 style="
        margin: 0 0 20px 0;
        text-align: center;
        font-size: 20px;
        font-weight: 600;
        color: #333;
        letter-spacing: 0.5px;
    ">
        Customer Complaints
    </h3>

    <!-- CHART AREA -->
    <div style="
        width: 100%;
        height: 500px;      /* chart height */
        padding: 5px 0;
    ">
        <canvas id="complaintChart"></canvas>
    </div>

</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    new Chart(document.getElementById('complaintChart'), {
        type: 'bar',
        data: {
            labels: ['Complaints'],
            datasets: [{
                label: 'Total Complaints',
                data: [${totalComplaints}],
                backgroundColor: 'rgba(54, 162, 235, 0.85)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 2,
                borderRadius: 12
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: true, position: 'top' }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(0,0,0,0.08)' },
                    ticks: { color: '#555' }
                },
                x: {
                    grid: { display: false },
                    ticks: { color: '#555' }
                }
            }
        }
    });
</script>
    </div>
<div id="invoiceChartDiv">


<#-- Call the service -->
<#assign serviceResult = dispatcher.runSync("MonthlyPaidSalesInvoices", {}) />
<#assign monthlyList = serviceResult.monthlyInvoiceList?default([]) />

<div class="card" style="padding: 20px; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); margin: 20px;">
    <h3 style="text-align:center; margin-bottom:20px;">Monthly Sales Invoices Received for Current Year</h3>
    <canvas id="monthlyInvoiceChart" style="width:100%; height:400px;"></canvas>
    <#-- Message if empty -->
    <#if monthlyList?size == 0>
        <p style="text-align:center; color:#777;">No invoices found for selected criteria.</p>
    </#if>
</div><script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {

    // Fixed Jan–Dec labels
    const fixedMonths = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

    // Convert YYYY-MM → Month name
    function convertYYYYMM(value) {
        if (!value) return null;
        const parts = value.split("-");
        if (parts.length === 2) {
            const monthNum = parts[1];
            const numToShort = {
                "01":"Jan","02":"Feb","03":"Mar","04":"Apr","05":"May","06":"Jun",
                "07":"Jul","08":"Aug","09":"Sep","10":"Oct","11":"Nov","12":"Dec"
            };
            return numToShort[monthNum];
        }
        return null;
    }

    // Map month -> invoice count
    const monthMap = {};
    <#list monthlyList as monthData>
        monthMap[convertYYYYMM("${monthData.month}")] = ${monthData.totalInvoices};
    </#list>

    // Final Jan–Dec data
    const chartData = fixedMonths.map(m => monthMap[m] ?? 0);

    // 🎨 12 unique colors (one for each month)
    const backgroundColors = [
        'rgba(255, 99, 132, 0.8)',   // Jan
        'rgba(54, 162, 235, 0.8)',   // Feb
        'rgba(255, 206, 86, 0.8)',   // Mar
        'rgba(75, 192, 192, 0.8)',   // Apr
        'rgba(153, 102, 255, 0.8)',  // May
        'rgba(255, 159, 64, 0.8)',   // Jun
        'rgba(0, 204, 102, 0.8)',    // Jul
        'rgba(255, 102, 255, 0.8)',  // Aug
        'rgba(102, 255, 102, 0.8)',  // Sep
        'rgba(102, 153, 255, 0.8)',  // Oct
        'rgba(255, 102, 102, 0.8)',  // Nov
        'rgba(255, 204, 102, 0.8)'   // Dec
    ];

    // Matching border colors
    const borderColors = backgroundColors.map(c => c.replace("0.8", "1"));

    const ctx = document.getElementById('monthlyInvoiceChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: fixedMonths,
            datasets: [{
                label: 'Total Paid Sales Invoices',
                data: chartData,
                backgroundColor: backgroundColors,
                borderColor: borderColors,
                borderWidth: 2,
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
});
</script>


</div>

</div>

<!-- =============================
     TOGGLE LOGIC
============================= -->
<script>
document.addEventListener("DOMContentLoaded", () => {
    const buttons = document.querySelectorAll(".topbar-btn");

    buttons.forEach(btn => {
        btn.addEventListener("click", () => {
            
            // Remove active class from all buttons
            buttons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");

            const target = btn.dataset.target;

            if(target === "allCharts") {
                // Show all charts
                document.querySelectorAll("#allCharts > div").forEach(d => d.style.display = "block");
            } else {
                // Hide all charts
                document.querySelectorAll("#allCharts > div").forEach(d => d.style.display = "none");
                // Show only the target chart
                const el = document.getElementById(target);
                if(el) el.style.display = "block";
            }
        });
    });
});
</script>

<style>
.topbar-btn {
    padding: 8px 16px;
    border-radius: 8px;
    border: none;
    background: #696969ff;
    cursor: pointer;
    font-weight: 500;

    /* Smooth animation */
    transition: background-color 0.45s ease, color 0.45s ease,
                transform 0.35s ease, box-shadow 0.45s ease;
}

/* Hover effect */
.topbar-btn:hover {
    background: #d0d0d0;
    transform: translateY(-2px) scale(1.05);
    box-shadow: 0 6px 15px rgba(0,0,0,0.2);
}

/* Press click animation */
.topbar-btn:active {
    transform: translateY(0px) scale(0.97);
    box-shadow: 0 2px 6px rgba(0,0,0,0.15);
}

/* Active (selected) state */
.topbar-btn.active {
    background: #004aad;
    color: white;
    transform: translateY(-2px) scale(1.08);
    box-shadow: 0 8px 20px rgba(0, 74, 173, 0.35);
}
</style>