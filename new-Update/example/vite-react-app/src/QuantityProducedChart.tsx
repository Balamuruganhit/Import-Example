import React, { useEffect, useState, useCallback, useMemo } from "react";
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
  const [filteredData, setFilteredData] = useState<QuantityData[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Pagination + control state
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(10);
  const [jumpPage, setJumpPage] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  const [debouncedSearch, setDebouncedSearch] = useState("");

  const pageButtonLimit = 5;

  // Debounce search for smoother typing
  useEffect(() => {
    const timer = setTimeout(() => setDebouncedSearch(searchTerm), 400);
    return () => clearTimeout(timer);
  }, [searchTerm]);

  // Fetch Data (optimized for real-time updates)
  const fetchData = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const result = await pipe(
        apiGet(
          `/services/ListQuantityProducedData?page=${currentPage}&itemsPerPage=${itemsPerPage}`
        )
      )();

      if (E.isLeft(result)) throw new Error(result.left.message);
      const json = await result.right.json();

      const list = json?.data?.workEffortList ?? json?.workEffortList ?? [];
      const mapped = list.map((item: any, index: number) => ({
        name: item.workEffortId || `WE-${index + 1}`,
        quantityToProduce: parseFloat(item.quantityToProduce || 0),
        quantityProduced: parseFloat(item.quantityProduced || 0),
      }));

      setData(mapped);
      setFilteredData(mapped);
    } catch (err: any) {
      setError(err.message || "Error fetching data");
    } finally {
      setLoading(false);
    }
  }, [apiGet, currentPage, itemsPerPage]);

  // Fetch on page or size change
  useEffect(() => {
    fetchData();
  }, [fetchData]);

  // Filter data by search term (debounced)
  useEffect(() => {
    if (debouncedSearch.trim() === "") {
      setFilteredData(data);
    } else {
      const lower = debouncedSearch.toLowerCase();
      setFilteredData(data.filter((d) => d.name.toLowerCase().includes(lower)));
    }
    setCurrentPage(1);
  }, [debouncedSearch, data]);

  // Pagination logic
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const startPage =
    Math.floor((currentPage - 1) / pageButtonLimit) * pageButtonLimit + 1;
  const endPage = Math.min(startPage + pageButtonLimit - 1, totalPages);
  const visiblePages = useMemo(
    () =>
      Array.from({ length: endPage - startPage + 1 }, (_, i) => startPage + i),
    [startPage, endPage]
  );

  const paginatedData = useMemo(
    () =>
      filteredData.slice(
        (currentPage - 1) * itemsPerPage,
        currentPage * itemsPerPage
      ),
    [filteredData, currentPage, itemsPerPage]
  );

  // --- UI Rendering
  if (loading)
    return <div className="loading-text">Loading Quantity Data...</div>;
  if (error) return <div className="error-text">{error}</div>;

  return (
    <div className="card-animated">
      <h2 className="chart-title">Planned Vs Actual Production</h2>
      <p className="chart-subtitle">
        Displays the planned vs actual production quantities
      </p>

      {/* Top controls: items per page + search */}
      <div
        style={{
          marginBottom: "10px",
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
        }}
      >
        <label>
          Items per page:{" "}
          <select
            value={itemsPerPage}
            onChange={(e) => {
              setItemsPerPage(Number(e.target.value));
              setCurrentPage(1);
            }}
          >
            {[5, 10, 20, 50, 100].map((n) => (
              <option key={n} value={n}>
                {n}
              </option>
            ))}
          </select>
        </label>

        <label>
          Search:{" "}
          <input
            type="text"
            value={searchTerm}
            placeholder="Enter WorkEffort ID"
            onChange={(e) => setSearchTerm(e.target.value)}
            style={{
              width: "180px",
              padding: "4px 8px",
              borderRadius: "6px",
              border: "1px solid #ccc",
            }}
          />
        </label>
      </div>

      {/* Chart */}
      <div className="chart-container">
        <ResponsiveContainer width="100%" height={350}>
          <BarChart
            data={paginatedData}
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
            <YAxis tick={{ fontSize: 12, fill: "#333" }} />
            <Tooltip
              contentStyle={{
                backgroundColor: "#f4f8ff",
                borderRadius: 10,
              }}
            />
            <Legend />
            <Bar
              dataKey="quantityToProduce"
              fill="#33b5e5"
              name="Planned Quantity"
              animationDuration={800}
            />
            <Bar
              dataKey="quantityProduced"
              fill="#055e7eff"
              name="Actual Quantity"
              animationDuration={800}
            />
          </BarChart>
        </ResponsiveContainer>
      </div>

      {/* Pagination Controls */}
      <div className="pagination-controls">
        <button
          disabled={currentPage === 1}
          onClick={() => setCurrentPage((prev) => prev - 1)}
        >
          Previous
        </button>

        {visiblePages.map((num) => (
          <button
            key={num}
            className={num === currentPage ? "active-page" : ""}
            onClick={() => setCurrentPage(num)}
          >
            {num}
          </button>
        ))}

        {endPage < totalPages && <span>…</span>}

        <button
          disabled={currentPage === totalPages || totalPages === 0}
          onClick={() => setCurrentPage((prev) => prev + 1)}
        >
          Next
        </button>

        <span style={{ marginLeft: "10px", fontWeight: "bold" }}>
          Page {currentPage} of {totalPages}
        </span>

        <span style={{ marginLeft: "10px" }}>
          Go to page:{" "}
          <input
            type="number"
            min={1}
            max={totalPages}
            placeholder="Enter page"
            value={jumpPage}
            onChange={(e) => setJumpPage(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") {
                const page = Number(jumpPage);
                if (page >= 1 && page <= totalPages) {
                  setCurrentPage(page);
                  setJumpPage("");
                }
              }
            }}
            style={{ width: "80px", marginLeft: "5px" }}
          />
        </span>
      </div>
    </div>
  );
};

export default QuantityProducedChart;
