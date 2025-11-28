

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
  name: string; // product internal name
  quantityToProduce: number; // planned quantity
  quantityProduced: number; // actual quantity
  createdStamp?: string;
}

const QuantityProducedChart: React.FC = () => {
  const { get: apiGet } = useApi();
  const [data, setData] = useState<QuantityData[]>([]);
  const [filteredData, setFilteredData] = useState<QuantityData[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(10);
  const [jumpPage, setJumpPage] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  const [debouncedSearch, setDebouncedSearch] = useState("");
  const [selectedMonth, setSelectedMonth] = useState<string>("");

  const pageButtonLimit = 5;

  // Debounce search input
  useEffect(() => {
    const timer = setTimeout(() => setDebouncedSearch(searchTerm), 200);
    return () => clearTimeout(timer);
  }, [searchTerm]);

  // Fetch data from API
  const fetchData = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const result = await pipe(apiGet(`/services/ListQuantityProducedData`))();
      if (E.isLeft(result)) throw new Error(result.left.message);
      const json = await result.right.json();

      console.log("API Response:", json); // Debug

      const list =
        json?.workEffortList ||
        json?.data?.workEffortList ||
        json?.response?.workEffortList ||
        [];

      if (!list.length) {
        setError("No data returned from server");
        setData([]);
        setFilteredData([]);
        setLoading(false);
        return;
      }

      // Map API data to QuantityData
      const mapped: QuantityData[] = list.map((item: any, index: number) => ({
        name: item.productName || `Product-${index + 1}`,
        quantityToProduce: parseFloat(item.quantityPlanned ?? 0),
        quantityProduced: parseFloat(item.quantityActual ?? 0),
        createdStamp: item.createdStamp,
      }));

      setData(mapped);
      setFilteredData(mapped);
    } catch (err: any) {
      console.error("❌ Fetch error:", err);
      setError(err.message || "Error fetching data");
    } finally {
      setLoading(false);
    }
  }, [apiGet]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  // Compute available months
  const availableMonths = useMemo(() => {
    const monthsSet = new Set<string>();
    data.forEach((d) => {
      if (d.createdStamp) {
        const date = new Date(d.createdStamp);
        if (!isNaN(date.getTime())) {
          const monthStr = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}`;
          monthsSet.add(monthStr);
        }
      }
    });
    return Array.from(monthsSet).sort((a, b) => (a < b ? 1 : -1));
  }, [data]);

  // Filter data (search + month)
  useEffect(() => {
    let filtered = data;

    if (debouncedSearch.trim()) {
      const lower = debouncedSearch.toLowerCase();
      filtered = filtered.filter((d) => d.name.toLowerCase().includes(lower));
    }

    if (selectedMonth) {
      filtered = filtered.filter((d) => {
        if (!d.createdStamp) return false;
        const date = new Date(d.createdStamp);
        if (isNaN(date.getTime())) return false;
        const monthStr = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}`;
        return monthStr === selectedMonth;
      });
    }

    setFilteredData(filtered);
    setCurrentPage(1);
  }, [debouncedSearch, data, selectedMonth]);

  // Pagination
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const startPage = Math.floor((currentPage - 1) / pageButtonLimit) * pageButtonLimit + 1;
  const endPage = Math.min(startPage + pageButtonLimit - 1, totalPages);

  const visiblePages = useMemo(
    () => Array.from({ length: endPage - startPage + 1 }, (_, i) => startPage + i),
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

  if (loading) return <div className="loading-text">Loading Quantity Data...</div>;
  if (error) return <div className="error-text">{error}</div>;

  return (
    <div className="card-animated">
      <h2 className="chart-title">Planned Vs Actual Production</h2>
      <p className="chart-subtitle">
        Displays the planned vs actual production quantities
      </p>

      {/* Controls */}
      <div className="controls">
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
              <option key={n} value={n}>{n}</option>
            ))}
          </select>
        </label>

        <label>
          Search:{" "}
          <input
            type="text"
            value={searchTerm}
            placeholder="Enter Product Name"
            onChange={(e) => setSearchTerm(e.target.value)}
            autoComplete="off"
            style={{ outline: "none" }}
          />
        </label>

        <label>
          Month:{" "}
          <select
            value={selectedMonth}
            onChange={(e) => setSelectedMonth(e.target.value)}
          >
            <option value="">All</option>
            {availableMonths.map((month) => (
              <option key={month} value={month}>{month}</option>
            ))}
          </select>
        </label>
      </div>

      {/* Chart */}
      <div className="chart-container" style={{ height: "400px" }}>
        {filteredData.length === 0 ? (
          <div className="no-data-text">🔍 No matching records found.</div>
        ) : (
          <ResponsiveContainer width="100%" height="100%">
            <BarChart
              data={paginatedData}
              margin={{ top: 20, right: 30, left: 20, bottom: 80 }}
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
              <Tooltip contentStyle={{ backgroundColor: "#f4f8ff", borderRadius: 10 }} />
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
        )}
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="pagination-controls">
          <button disabled={currentPage === 1} onClick={() => setCurrentPage((prev) => prev - 1)}>Previous</button>

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
                  e.preventDefault();
                  const page = Number(jumpPage);
                  if (page >= 1 && page <= totalPages) {
                    setCurrentPage(page);
                    setJumpPage("");
                  }
                }
              }}
              style={{ width: "70px", marginLeft: "5px" }}
            />
          </span>
        </div>
      )}
    </div>
  );
};

export default QuantityProducedChart;
