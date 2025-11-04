import { useEffect, useState, useCallback, useRef } from "react";
import "./App.css";
import { useApi } from "./ApiContext";
import { pipe } from "fp-ts/lib/function";
import * as E from "fp-ts/lib/Either";
import Preloader from "./Preloader";
import Greeting from "./Greeting";
import QuoteItemAmounts from "./QuoteItemAmountStats";
import OrderAmountStats from "./OrderAmountStats";

import {
  Chart as ChartJS,
  ArcElement,
  Tooltip,
  Legend,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
} from "chart.js";
import { Pie, Bar } from "react-chartjs-2";


// Register ChartJS modules
ChartJS.register(ArcElement, Tooltip, Legend, CategoryScale, LinearScale, BarElement, Title);

function App() {
  const reworkRejectedChartRef = useRef<any>(null);

  const { get: apiGet } = useApi();
 const [loading, setLoading] = useState(true);
  const [fadeIn, setFadeIn] = useState(false);
  // --- Pie Chart / Stats Data ---
  const [orderData, setOrderData] = useState<any[]>([]);
  const [quoteData, setQuoteData] = useState<any[]>([]);
  const [requestData, setRequestData] = useState<any[]>([]);
  const [yearlyOrders, setYearlyOrders] = useState<any[]>([]);

  const [salesStats, setSalesStats] = useState({ complete: 0, onProcess: 0 });
  const [purchaseStats, setPurchaseStats] = useState({ complete: 0, onProcess: 0 });
  const [quoteStats, setQuoteStats] = useState({ created: 0, ordered: 0 });
  const [requestStats, setRequestStats] = useState({ total: 0, onProcess: 0 });

  const [animatedSalesComplete, setAnimatedSalesComplete] = useState(0);
  const [animatedSalesOnProcess, setAnimatedSalesOnProcess] = useState(0);
  const [animatedPurchaseComplete, setAnimatedPurchaseComplete] = useState(0);
  const [animatedPurchaseOnProcess, setAnimatedPurchaseOnProcess] = useState(0);
  const [animatedQuoteCreated, setAnimatedQuoteCreated] = useState(0);
  const [animatedQuoteOrdered, setAnimatedQuoteOrdered] = useState(0);
  const [animatedRequestTotal, setAnimatedRequestTotal] = useState(0);
  const [animatedRequestOnProcess, setAnimatedRequestOnProcess] = useState(0);
  const [animatedRework, setAnimatedRework] = useState(0);
  const [animatedRejected, setAnimatedRejected] = useState(0);
 const [reworkRejectedStats, setReworkRejectedStats] = useState({ rework: 0, rejected: 0 });

  // --- Monthly Bar Chart Data ---
  const [monthlySales, setMonthlySales] = useState<any[]>([]);
  const [monthlyPurchases, setMonthlyPurchases] = useState<any[]>([]);
  const [monthlyQuotes, setMonthlyQuotes] = useState<any[]>([]);
  const [loadingMonthly, setLoadingMonthly] = useState(true);
  const [errorMonthly, setErrorMonthly] = useState<string | null>(null);

  // --- Production & Work Orders Pie Data ---
  const [productionRunData, setProductionRunData] = useState<any[]>([]);
  const [workOrderData, setWorkOrderData] = useState<any[]>([]);

  // --- Monthly Production & Work Order Bar Charts ---
  const [monthlyProductionStats, setMonthlyProductionStats] = useState<any[]>([]);
  const [monthlyWorkOrderStats, setMonthlyWorkOrderStats] = useState<any[]>([]);
  const [loadingMonthlyExtra, setLoadingMonthlyExtra] = useState(true);
  const [errorMonthlyExtra, setErrorMonthlyExtra] = useState<string | null>(null);

  // --- Chart Refs ---
  const orderChartRef = useRef<any>(null);
  const quoteChartRef = useRef<any>(null);
  const requestChartRef = useRef<any>(null);
  const productionChartRef = useRef<any>(null);
  const workOrderChartRef = useRef<any>(null);
  const monthlySalesRef = useRef<any>(null);
  const monthlyPurchaseRef = useRef<any>(null);
  const monthlyQuoteRef = useRef<any>(null);
  const yearlyOrdersRef = useRef<any>(null);
  const monthlyProductionRef = useRef<any>(null);
  const monthlyWorkOrderRef = useRef<any>(null);
// --- Popup state for showing WorkEffort IDs ---
const [showPopup, setShowPopup] = useState(false);
const [popupTitle, setPopupTitle] = useState("");
const [workEffortIds, setWorkEffortIds] = useState<string[]>([]);

const handlePieSliceClick = async (event: any) => {
  const chart = reworkRejectedChartRef.current;
  if (!chart) return;

  const elements = chart.getElementsAtEventForMode(
    event,
    "nearest",
    { intersect: true },
    true
  );

  if (!elements.length) return;

  const element = elements[0];
  const label = chart.data.labels[element.index]; // "Rework" or "Rejected"
  const serviceName =
    label === "Rework" ? "ListReworkWorkEfforts" : "ListRejectedWorkEfforts";

  try {
    const result = await pipe(apiGet(`/services/${serviceName}`))();
    if (E.isRight(result)) {
      const json = await result.right.json();
      const ids =
        json?.data?.workEffortIds ??
        json?.workEffortIds ??
        [];

      setWorkEffortIds(ids);
      setPopupTitle(`${label} WorkEffort IDs`);
      setShowPopup(true);
    } else {
      console.error("API Error:", result.left.message);
    }
  } catch (err) {
    console.error("Error fetching work effort IDs:", err);
  }
};


  // --- Fetch Pie/Stats Data ---
  const fetchApiData = useCallback(
    async (path: string) => {
      try {
        const result = await pipe(apiGet(path))();
        if (E.isLeft(result)) {
          console.error("API Error:", result.left.message);
        } else {
          const json = await result.right.json();

          // --- Orders
          if (json.data?.orderCountList) {
            setOrderData(json.data.orderCountList);

            const salesOrder =
              json.data.orderCountList.find((item: any) => item.label === "Sales Orders")?.value || 0;
            const completedSales =
              json.data.orderCountList.find((item: any) => item.label === "Completed Sales Orders")?.value || 0;
            const completePercent = salesOrder > 0 ? Math.round((completedSales / salesOrder) * 100) : 0;
            setSalesStats({ complete: completePercent, onProcess: 100 - completePercent });

            const purchaseOrder =
              json.data.orderCountList.find((item: any) => item.label === "Purchase Orders")?.value || 0;
            const completedPurchase =
              json.data.orderCountList.find((item: any) => item.label === "Completed Purchase Orders")?.value || 0;
            const purchaseCompletePercent =
              purchaseOrder > 0 ? Math.round((completedPurchase / purchaseOrder) * 100) : 0;
            setPurchaseStats({ complete: purchaseCompletePercent, onProcess: 100 - purchaseCompletePercent });
          }

          // --- Quotes
          if (json.data?.quoteCountList) {
            setQuoteData(json.data.quoteCountList);

            const created = json.data.quoteCountList.find((item: any) => item.label === "Created Quotes")?.value || 0;
            const ordered = json.data.quoteCountList.find((item: any) => item.label === "Ordered Quotes")?.value || 0;
            setQuoteStats({ created, ordered });
          }

          // --- Requests
          if (json.data?.requestCountList) {
            setRequestData(json.data.requestCountList);

            const totalRequests =
              json.data.requestCountList.find((item: any) => item.label === "Total Requests")?.value || 0;
            const onProcessRequests =
              json.data.requestCountList.find((item: any) => item.label === "On Process Requests")?.value || 0;
            setRequestStats({ total: totalRequests, onProcess: onProcessRequests });
          }
        }
      } catch (err) {
        console.error(err);
      }
    },
    [apiGet]
  );
  // --- Fetch Rework/Rejected ---
 const fetchReworkRejectedData = useCallback(async () => {
  try {
    const result = await pipe(apiGet("/services/ListReworkAndRejectedCounts"))();
    if (E.isRight(result)) {
      const json = await result.right.json();

      // ✅ Works whether OFBiz wraps data or not
      const reworkCount = json?.data?.reworkCount ?? json?.reworkCount ?? 0;
      const rejectedCount = json?.data?.rejectedCount ?? json?.rejectedCount ?? 0;

      setReworkRejectedStats({ rework: reworkCount, rejected: rejectedCount });
      console.log("✅ Rework/Rejected JSON:", json);
    } else {
      console.error("❌ API Error:", result.left.message);
    }
  } catch (err) {
    console.error("❌ Error fetching rework/rejected data:", err);
  }
}, [apiGet]);


  useEffect(() => {
    fetchApiData("/services/ListOrderValues");
    fetchApiData("/services/ListQuoteValues");
    fetchApiData("/services/ListRequestValues");
  }, [fetchApiData]);
useEffect(() => {
  fetchReworkRejectedData();
}, [fetchReworkRejectedData]);

  // --- Animate Stat Counters ---
  useEffect(() => {
    const duration = 1000;
    const stepTime = 20;

    const animateValue = (target: number, setter: (val: number) => void) => {
      let start = 0;
      const step = Math.ceil(target / (duration / stepTime));
      const interval = setInterval(() => {
        start += step;
        if (start >= target) {
          setter(target);
          clearInterval(interval);
        } else {
          setter(start);
        }
      }, stepTime);
    };

    animateValue(salesStats.complete, setAnimatedSalesComplete);
    animateValue(salesStats.onProcess, setAnimatedSalesOnProcess);
    animateValue(purchaseStats.complete, setAnimatedPurchaseComplete);
    animateValue(purchaseStats.onProcess, setAnimatedPurchaseOnProcess);
    animateValue(quoteStats.created, setAnimatedQuoteCreated);
    animateValue(quoteStats.ordered, setAnimatedQuoteOrdered);
    animateValue(requestStats.total, setAnimatedRequestTotal);
    animateValue(requestStats.onProcess, setAnimatedRequestOnProcess);
    animateValue(reworkRejectedStats.rework, setAnimatedRework);
    animateValue(reworkRejectedStats.rejected, setAnimatedRejected);
  }, [salesStats, purchaseStats, quoteStats, requestStats, reworkRejectedStats]);

  // --- Fetch Monthly + Yearly Bar Charts ---
  const fetchChartData = useCallback(async () => {
    try {
      setLoadingMonthly(true);
      setErrorMonthly(null);

      const callService = async (path: string) => {
        const result = await pipe(apiGet(path))();
        if (E.isLeft(result)) throw new Error(result.left.message);
        const json = await result.right.json();
        return json.data || json;
      };

      const salesData = await callService("/services/ListMonthlySalesOrders");
      const purchaseData = await callService("/services/ListMonthlyPurchaseOrders");
      const quoteData = await callService("/services/ListMonthlyQuotes");
      const yearlyData = await callService("/services/listYearlyOrders");

      setMonthlySales(salesData?.monthlySalesList || []);
      setMonthlyPurchases(purchaseData?.monthlyPurchaseList || []);
      setMonthlyQuotes(quoteData?.monthlyQuoteList || []);
      setYearlyOrders(yearlyData?.yearlyOrdersList || []);
    } catch (err: any) {
      console.error(err);
      setErrorMonthly(err.message || "Error fetching data");
    } finally {
      setLoadingMonthly(false);
    }
  }, [apiGet]);

  useEffect(() => {
    fetchChartData();
  }, [fetchChartData]);

  // --- Fetch Production & Work Orders Pie Data ---
  const fetchExtraPieData = useCallback(async () => {
    try {
      const prodRes = await pipe(apiGet("/services/ListProductionRunValues"))();
      if (E.isRight(prodRes)) {
        const json = await prodRes.right.json();
        setProductionRunData(
          json.data?.productionRunList || [
            { label: "Created Productions", value: 0 },
            { label: "Closed Productions", value: 0 },
          ]
        );
      }

      const workRes = await pipe(apiGet("/services/ListWorkOrderValues"))();
      if (E.isRight(workRes)) {
        const json = await workRes.right.json();
        setWorkOrderData(
          json.data?.workOrderCountList || [
            { label: "Total Work Orders", value: 0 },
            { label: "Created Work Orders", value: 0 },
            { label: "Approved Work Orders", value: 0 },
            { label: "Completed Work Orders", value: 0 },
          ]
        );
      }
    } catch (err) {
      console.error("Error fetching production/work order data:", err);
    }
  }, [apiGet]);

  useEffect(() => {
    fetchExtraPieData();
  }, [fetchExtraPieData]);

  // --- Fetch Monthly Production & Work Order Stats ---
  const fetchMonthlyExtraCharts = useCallback(async () => {
    try {
      setLoadingMonthlyExtra(true);
      setErrorMonthlyExtra(null);

      const callService = async (path: string) => {
        const result = await pipe(apiGet(path))();
        if (E.isLeft(result)) throw new Error(result.left.message);
        const json = await result.right.json();
        return json.data || json;
      };
 // ✅ Fetch data
      const productionData = await callService("/services/ListMonthlyProductionStats");
      const workOrderData = await callService("/services/ListMonthlyWorkOrderStats");

      console.log("✅ Production Data:", productionData);
      console.log("✅ WorkOrder Data:", workOrderData);

      // === Ensure Jan-Dec always present ===
      const months = [
        "January","February","March","April","May","June",
        "July","August","September","October","November","December"
      ];

      const fillMonthlyData = (data: any[]) => {
        const map = data.reduce((acc: any, curr: any) => {
          acc[curr.label] = Number(curr.value) || 0;
          return acc;
        }, {});
        return months.map((m) => ({ label: m, value: map[m] || 0 }));
      };

      // ✅ Handle both naming formats from backend
      const prodList =
        productionData?.monthlyProductionList ||
        productionData?.monthlyProductionStats ||
        productionData?.monthlyProduction ||
        [];

      const workList =
        workOrderData?.monthlyWorkOrderList ||
        workOrderData?.monthlyWorkOrderStats ||
        workOrderData?.monthlyWorkOrder ||
        [];

      setMonthlyProductionStats(fillMonthlyData(prodList));
      setMonthlyWorkOrderStats(fillMonthlyData(workList));
    } catch (err: any) {
      console.error("❌ Error fetching monthly extra charts:", err);
      setErrorMonthlyExtra(err.message || "Error fetching monthly production/work order stats");
    } finally {
      setLoadingMonthlyExtra(false);
    }
  }, [apiGet]);

  useEffect(() => {
    fetchMonthlyExtraCharts();
  }, [fetchMonthlyExtraCharts]);

  // --- Chart Configs ---
  const createPieChartData = (data: any[]) => ({
    labels: data.map((item) => item.label),
    datasets: [
      {
        label: "Counts",
        data: data.map((item) => item.value),
        backgroundColor: ["#127a7aff", "#964b5cff", "#767470ff","#228efbff", "#6e189dff","#e2d774ff","#E97451ff","#6ba223ff", "#5a24c7ff","#dd4141ff","#a57b36ff"],
        hoverOffset: 10,
      },
    ],
  });

  const createBarChartData = (data: any[], label: string, color: string) => ({
    labels: data.map((d) => d.label),
    datasets: [
      {
        label,
        data: data.map((d) => d.value),
        backgroundColor: color,
        barPercentage: 0.9,
        categoryPercentage: 0.6,
      },
    ],
  });

  const getSuggestedMax = (data: any[]) => Math.ceil(Math.max(...data.map((d) => d.value), 1) * 1.2);

  const createBarChartOptions = (data: any[], title: string) => ({
    responsive: true,
    maintainAspectRatio: false,
    plugins: { legend: { position: "top" as const }, title: { display: true, text: title } },
    scales: { y: { beginAtZero: true, suggestedMax: getSuggestedMax(data), ticks: { stepSize: 1 } } },
    animation: { duration: 1000 },
  });

// --- Auto-refresh every 500 seconds ---
useEffect(() => {
  const interval = setInterval(() => {
    fetchApiData("/services/ListOrderValues");
    fetchApiData("/services/ListQuoteValues");
    fetchApiData("/services/ListRequestValues");
    fetchReworkRejectedData();
    fetchChartData();
    fetchExtraPieData();
    fetchMonthlyExtraCharts();

    setTimeout(() => {
      orderChartRef.current?.update();
      quoteChartRef.current?.update();
      requestChartRef.current?.update();
      productionChartRef.current?.update();
      workOrderChartRef.current?.update();
      monthlySalesRef.current?.update();
      monthlyPurchaseRef.current?.update();
      monthlyQuoteRef.current?.update();
      yearlyOrdersRef.current?.update();
      monthlyProductionRef.current?.update();
      monthlyWorkOrderRef.current?.update();
    }, 200);
  }, 1000_000);

  return () => clearInterval(interval);
}, [fetchApiData, fetchChartData, fetchExtraPieData, fetchMonthlyExtraCharts]);

  const handlePreloaderFinish = () => {
    setLoading(false);
    setTimeout(() => setFadeIn(true), 50); 
  };

  if (loading) {
    return <Preloader onFinish={handlePreloaderFinish} />;
  }
  return (
     <div className={`App ${fadeIn ? "fade-in" : ""}`}>
        {/* --- Greeting --- */}
    <div className="dashboard-greeting">
      <Greeting />
    </div>
{/* --- Combined Stats Section --- */}
<div className="stats-row">
  {/* --- Top Stat Boxes --- */}
  {[{
    title: "Total Sale Order",
    values: [
      { label: "Complete %", value: animatedSalesComplete },
      { label: "On Process %", value: animatedSalesOnProcess },
    ]
  }, {
    title: "Total Purchase Order",
    values: [
      { label: "Complete %", value: animatedPurchaseComplete },
      { label: "On Process %", value: animatedPurchaseOnProcess },
    ]
  }, {
    title: "Total Quote",
    values: [
      { label: "Created", value: animatedQuoteCreated },
      { label: "Ordered", value: animatedQuoteOrdered },
    ]
  }, {
    title: "Total Request",
    values: [
      { label: "Total", value: animatedRequestTotal },
      { label: "On Process", value: animatedRequestOnProcess },
    ]
  }, {
    title: "Production Run",
    values: [
      { label: "Created", value: productionRunData.find((i) => i.label === "Created Productions")?.value || 0 },
      { label: "Closed", value: productionRunData.find((i) => i.label === "Closed Productions")?.value || 0 },
    ]
  },{
                title: "Productions Rework & Rejected", 
            values: [
              { label: "Rework", value: animatedRework },
              { label: "Rejected", value: animatedRejected },
            ],
          },
     {
    title: "Work Orders",
    values: [
      { label: "Total", value: workOrderData.find((i) => i.label === "Total Work Orders")?.value || 0 },
      { label: "Completed", value: workOrderData.find((i) => i.label === "Completed")?.value || 0 },
    ]
  }].map((stat, idx) => (
    <div className="stat-box" key={idx}>
      <h2 className="stat-title">{stat.title}</h2>
      <div className="stat-inner">
        <div className="stat-column">
          <p className="stat-label">{stat.values[0].label}</p>
          <p className="stat-value">{stat.values[0].value}</p>
        </div>
        <div className="vertical-divider"></div>
        <div className="stat-column">
          <p className="stat-label">{stat.values[1].label}</p>
          <p className="stat-value">{stat.values[1].value}</p>
        </div>
      </div>
    </div>
  ))}

  {/* --- Order and Quote Amount Stats --- */}
  <div className="extra-stats-card">
    <OrderAmountStats />
  </div>

  <div className="extra-stats-card">
    <QuoteItemAmounts />
  </div>
</div>

      {/* --- Pie Charts --- */}
      <div className="charts-row">
        {[{ title: "Order Counts", data: orderData },
          { title: "Quote Counts", data: quoteData },
          { title: "Request Counts", data: requestData }].map((chart, idx) => (
          <div className="chart-card" key={idx}>
            <h2>{chart.title}</h2>
            <div className="chart-container">
              {chart.data.length > 0 ? (
                <Pie
                  ref={chart.title === "Order Counts" ? orderChartRef :
                       chart.title === "Quote Counts" ? quoteChartRef :
                       requestChartRef}
                  data={createPieChartData(chart.data)}
                  options={{
                    maintainAspectRatio: false,
                    plugins: { legend: { position: "top" } },
                    cutout: chart.title === "Request Counts" ? "50%" : 0, // Donut
                    animation: { duration: 1000 },
                  }}
                   width={400}   // ⬅️ added
                    height={400}  // ⬅️ added
                />
              ) : (
                <div className="Preloader">Loading {chart.title.toLowerCase()}...</div>
              )}
            </div>
          </div>
        ))}
      </div>

      {/* --- Production & Work Order Pie Charts --- */}
      <div className="charts-row">
        <div className="chart-card">
          <h2>Production Run Summary</h2>
          {productionRunData.length > 0 ? (
            <div className="fixed-chart">
              <Pie ref={productionChartRef} data={createPieChartData(productionRunData)} options={{ maintainAspectRatio: false, animation: { duration: 1000 } }} />
            </div>
          ) : (
            <div className="Preloader">Loading production runs...</div>
          )}
        </div>

        <div className="chart-card">
          <h2>Work Order Summary</h2>
          {workOrderData.length > 0 ? (
            <div className="fixed-chart">
              <Pie ref={workOrderChartRef} data={createPieChartData(workOrderData)} options={{ maintainAspectRatio: false, animation: { duration: 1000 } }} />
            </div>
          ) : (
            <div className="Preloader">Loading work orders...</div>
          )}
        </div>
                {/* --- NEW: Rework & Rejected Donut Chart --- */}
  <div className="chart-card">
  <h2>Rework & Rejected</h2>
  {reworkRejectedStats.rework > 0 || reworkRejectedStats.rejected > 0 ? (
    <div className="fixed-chart">
      <Pie
        ref={reworkRejectedChartRef}
        data={createPieChartData([
          { label: "Rework", value: reworkRejectedStats.rework },
          { label: "Rejected", value: reworkRejectedStats.rejected },
        ])}
        options={{
          maintainAspectRatio: false,
          animation: { duration: 1000 },
          cutout: "60%",
          plugins: {
            legend: { position: "top" },
            title: { display: true, text: "Production Rework & Rejected" },
          },
          onClick: handlePieSliceClick, // attach the click handler
        }}
      />
    </div>
  ) : (
    <div className="Preloader">Loading rework/rejected data...</div>
  )}
</div>

      </div>

      {/* --- Monthly Charts --- */}
      {loadingMonthly ? (
        <p>Loading charts...</p>
      ) : errorMonthly ? (
        <p style={{ color: "red" }}>{errorMonthly}</p>
      ) : (
        <>
          <div className="charts-row">
            {[
              { title: "Monthly Sales Orders", data: monthlySales, color: "#d28405ff", label: "Sales Orders" },
              { title: "Monthly Purchase Orders", data: monthlyPurchases, color: "#bc1389ff", label: "Purchase Orders" },
              { title: "Monthly Quotes", data: monthlyQuotes, color: "#020b86ff", label: "Quotes" }
            ].map((chart, idx) => (
              <div className="chart-card" key={idx}>
                <h2>{chart.title}</h2>
                <div className="chart-container">
                  <Bar
                    ref={chart.title === "Monthly Sales Orders" ? monthlySalesRef :
                         chart.title === "Monthly Purchase Orders" ? monthlyPurchaseRef :
                         monthlyQuoteRef}
                    data={createBarChartData(chart.data, chart.label, chart.color)}
                    options={createBarChartOptions(chart.data, chart.title)}
                  />
                </div>
              </div>
            ))}
          </div>

          {/* Yearly Orders Comparison */}
          <div className="charts-row">
            <div className="chart-card" style={{ width: "100%", maxWidth: "1300px" }}>
              <h2>Yearly Orders Comparison</h2>
              <div className="chart-container" style={{ width: "100%", height: "400px" }}>
                <Bar
                  ref={yearlyOrdersRef}
                  data={createBarChartData(yearlyOrders, "Yearly Orders", "#00a86b")}
                  options={{ ...createBarChartOptions(yearlyOrders, "Yearly Orders Comparison"), maintainAspectRatio: false }}
                />
              </div>
            </div>
          </div>
        </>
      )}

      {/* --- Monthly Production & Work Order Bar Charts --- */}
      {loadingMonthlyExtra ? (
        <p>Loading monthly production & work order charts...</p>
      ) : errorMonthlyExtra ? (
        <p style={{ color: "red" }}>{errorMonthlyExtra}</p>
      ) : (
        <div className="charts-row">
          {[
            { title: "Monthly Production Stats", data: monthlyProductionStats, color: "#6b7622ff", label: "Productions" },
            { title: "Monthly Work Order Stats", data: monthlyWorkOrderStats, color: "#89614bff", label: "Work Orders" },
          ].map((chart, idx) => (
            <div className="chart-card" key={idx} style={{ width: "100%", maxWidth: "1100px" }}>
              <h2>{chart.title}</h2>
              <div className="chart-container" style={{ width: "100%", height: "400px" }}>
                <Bar
                  ref={chart.title === "Monthly Production Stats" ? monthlyProductionRef : monthlyWorkOrderRef}
                  data={createBarChartData(chart.data, chart.label, chart.color)}
                  options={{ ...createBarChartOptions(chart.data, chart.title), maintainAspectRatio: false }}
                />
              </div>
            </div>
          ))}
        </div>
      )}
      {/* --- Popup Modal for WorkEffort IDs --- */}
{showPopup && (
  <div className="popup-overlay" onClick={() => setShowPopup(false)}>
    <div className="popup-content" onClick={(e) => e.stopPropagation()}>
      <h3>{popupTitle}</h3>
      {workEffortIds.length > 0 ? (
        <ul>
          {workEffortIds.map((id, idx) => (
            <li key={idx}>{id}</li>
          ))}
        </ul>
      ) : (
        <p>No WorkEfforts found.</p>
      )}
      <button onClick={() => setShowPopup(false)}>Close</button>
    </div>
  </div>
)}
    </div>
  );
}

export default App;