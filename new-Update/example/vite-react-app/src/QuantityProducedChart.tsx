import React, { useEffect, useState, useCallback } from "react";
import { useApi } from "./ApiContext";
import { pipe } from "fp-ts/lib/function";
import * as E from "fp-ts/lib/Either";
import {
  BarChart,
  Bar,
  CartesianGrid,
  XAxis,
  YAxis,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";
import "./QuantityProducedChart.css";

interface QuantityData {
  name: string;
  quantityToProduce: number;
  quantityProduced: number;
}

const QuantityProducedChart: React.FC = () => {
  const { get: apiGet } = useApi();
  const [data, setData] = useState<QuantityData[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchData = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const result = await pipe(apiGet("/services/ListQuantityProducedData"))();
      if (E.isLeft(result)) throw new Error(result.left.message);

      const json = await result.right.json();
      console.log("✅ Raw Data:", json);

      const list = json?.data?.workEffortList ?? json?.workEffortList ?? [];

const mapped = list
  .map((item: any) => ({
    name: item.workEffortId,
    quantityToProduce: parseFloat(item.quantityToProduce || 0),
    quantityProduced: parseFloat(item.quantityProduced || 0),
  }))
  .filter((d: QuantityData) => d.quantityToProduce > 0 || d.quantityProduced > 0);


      console.log("✅ Cleaned Data:", mapped);
      setData(mapped);
    } catch (err: any) {
      console.error("❌ Error fetching data:", err);
      setError(err.message || "Error fetching quantity data");
    } finally {
      setLoading(false);
    }
  }, [apiGet]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  if (loading) return <div className="loading-text">Loading Quantity Data...</div>;
  if (error) return <div className="error-text">{error}</div>;

  return (
    <div className="card-animated">
      <h2 className="chart-title">Quantity Produced Overview</h2>
      <p className="chart-subtitle">
        WorkEffort: Quantity To Produce vs Quantity Produced
      </p>

      <div className="chart-container">
        <ResponsiveContainer width="100%" height={350}>
          <BarChart
            data={data}
            margin={{ top: 20, right: 30, left: 20, bottom: 60 }}
          >
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis
              dataKey="name"
              angle={-45}
              textAnchor="end"
              interval={0}
              height={80}
              tick={{ fontSize: 12, fill: "#444" }}
            />
            <YAxis
              tick={{ fontSize: 12, fill: "#333" }}
              domain={[0, "dataMax + 5"]}
            />
            <Tooltip
              contentStyle={{ backgroundColor: "#f4f8ff", borderRadius: 10 }}
            />
            <Legend />
            <Bar
              dataKey="quantityToProduce"
              fill="#33b5e5"
              name="Quantity To Produce"
              animationDuration={1000}
            />
            <Bar
              dataKey="quantityProduced"
              fill="#055e7eff"
              name="Quantity Produced"
              animationDuration={1000}
            />
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
};

export default QuantityProducedChart;
