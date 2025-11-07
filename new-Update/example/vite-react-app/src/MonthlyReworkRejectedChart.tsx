import { useEffect, useState, useCallback, useRef } from "react";
import { Bar } from "react-chartjs-2";
// Update the import path below if your ApiContext file is located elsewhere
import { useApi } from "./ApiContext";
import { pipe } from "fp-ts/lib/function";
import * as E from "fp-ts/lib/Either";
// import { createBarChartOptions } from "../chartOptions";
const createBarChartOptions = (data: any[], title: string) => ({
  plugins: {
    title: {
      display: true,
      text: title,
      font: { size: 18 }
    }
  }
});

/**
 * MonthlyReworkRejectedChart
 * - Uses the service: /services/ListMonthlyReworkRejectedStats
 * - Coerces values to numbers (handles BigDecimal serialized as strings)
 * - Matches the App's useApi hook (returns { get: apiGet })
 */

const MonthlyReworkRejectedChart = () => {
  // match your App's useApi usage: { get: apiGet }
  const { get: apiGet } = useApi();
  const [data, setData] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const chartRef = useRef<any>(null);

  const safeNumber = (v: any) => {
    // handle null, BigDecimal serialized as string, numbers, etc.
    if (v === null || v === undefined || v === "") return 0;
    try {
      // If it's already a number
      if (typeof v === "number") return v;
      // Try parseFloat on string representations
      const n = parseFloat(String(v));
      return Number.isNaN(n) ? 0 : n;
    } catch {
      return 0;
    }
  };

  const fetchMonthlyReworkRejected = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const result = await pipe(apiGet("/services/ListMonthlyReworkRejectedStats"))();

      if (E.isRight(result)) {
        const response = result.right as Response;
        const json = await response.json();
        const raw = json.data?.monthlyReworkRejectedStats || [];
        // normalize to ensure fields exist and values are numbers
        const normalized = raw.map((r: any) => ({
          label: r.label || "",
          rework: safeNumber(r.rework),
          rejected: safeNumber(r.rejected),
          total: safeNumber(r.total ?? (safeNumber(r.rework) + safeNumber(r.rejected))),
        }));
        setData(normalized);
      } else {
        setError(result.left?.message || "Service returned an error");
      }
    } catch (err: any) {
      console.error("Fetch error:", err);
      setError(err?.message || "Error fetching monthly Rework/Rejected data");
    } finally {
      setLoading(false);
    }
  }, [apiGet]);

  useEffect(() => {
    fetchMonthlyReworkRejected();
  }, [fetchMonthlyReworkRejected]);

  if (loading) return <p>Loading Monthly Rework vs Rejected chart...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  const chartData = {
    labels: data.map((d) => d.label),
    datasets: [
      {
        type: "bar" as const,
        label: "Rework Quantity",
        data: data.map((d) => d.rework),
        backgroundColor: "#ff9f40",
        barPercentage: 0.6,
        categoryPercentage: 0.6,
      },
      {
        type: "bar" as const,
        label: "Rejected Quantity",
        data: data.map((d) => d.rejected),
        backgroundColor: "#ff6384",
        barPercentage: 0.6,
        categoryPercentage: 0.6,
      },
      {
        type: "bar" as const,
        label: "Total (Rework + Rejected)",
        data: data.map((d) => d.total),
        backgroundColor: "rgba(54, 162, 235, 0.45)",
        barPercentage: 0.6,
        categoryPercentage: 0.6,
      },
    ],
  };

  const options = {
    ...createBarChartOptions(data, "Monthly Rework vs Rejected Quantities"),
    maintainAspectRatio: false,
    responsive: true,
    interaction: { mode: "index" as const, intersect: false },
    plugins: {
      legend: { position: "top" as const },
      tooltip: { mode: "index" as const, intersect: false },
    },
    scales: {
      x: {
        stacked: false,
      },
      y: {
        stacked: false,
        beginAtZero: true,
        ticks: { precision: 0 },
      },
    },
    animation: { duration: 800, easing: "easeOutQuart" as const },
  };

  return (
    <div className="chart-card" style={{ width: "95%", maxWidth: "1100px" }}>
      <h2>Monthly Rework vs Rejected Quantities</h2>
      <div className="chart-container" style={{ width: "100%", height: "400px" }}>
        <Bar ref={chartRef} data={chartData} options={options} />
      </div>
    </div>
  );
};

export default MonthlyReworkRejectedChart;
