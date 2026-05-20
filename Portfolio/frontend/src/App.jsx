import { useEffect,useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from './assets/vite.svg'
import heroImg from './assets/hero.png'
import './App.css'
import api from "./api";
import {
  LineChart,
  Line,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
} from "recharts";

function App() {
  const [monthlyRevenue, setMonthlyRevenue] = useState([]);
  const [categoryRevenue, setCategoryRevenue] = useState([]);
  const [topProducts, setTopProducts] = useState([]);
  const [aov, setAov] = useState(null);
  const [repeatRate, setRepeatRate] = useState(null);
  const [count, setCount] = useState(0)

  useEffect(() => {
    async function fetchData() {
      const [
        monthlyRes,
        categoryRes,
        productRes,
        aovRes,
        repeatRes,
      ] = await Promise.all([
        api.get("/revenue/monthly"),
        api.get("/revenue/by-category"),
        api.get("/products/top?limit=10"),
        api.get("/kpi/aov"),
        api.get("/kpi/repeat-rate"),
      ]);

      setMonthlyRevenue(monthlyRes.data);
      setCategoryRevenue(categoryRes.data);
      setTopProducts(productRes.data);
      setAov(aovRes.data.avg_order_value);
      setRepeatRate(repeatRes.data.repeat_rate);
    }

    fetchData();
  }, []);

  return (
    <div style={{ padding: "32px", fontFamily: "Arial, sans-serif" }}>
      <h1>ECサイト分析ダッシュボード</h1>
      <p>
        Django + PostgreSQL + React を用いて、SQLによる売上・顧客・商品分析を可視化しています。
      </p>

      <div style={{ display: "flex", gap: "16px", marginBottom: "32px" }}>
        <div style={cardStyle}>
          <h3>平均注文単価</h3>
          <p>¥{Number(aov || 0).toLocaleString()}</p>
        </div>

        <div style={cardStyle}>
          <h3>リピート率</h3>
          <p>{((repeatRate || 0) * 100).toFixed(1)}%</p>
        </div>
      </div>

      <section style={sectionStyle}>
        <h2>月別売上推移</h2>
        <ResponsiveContainer width="100%" height={300}>
          <LineChart data={monthlyRevenue}>
            <XAxis dataKey="month" />
            <YAxis />
            <Tooltip />
            <Line type="monotone" dataKey="revenue" />
          </LineChart>
        </ResponsiveContainer>
      </section>

      <section style={sectionStyle}>
        <h2>カテゴリ別売上</h2>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart data={categoryRevenue}>
            <XAxis dataKey="category" />
            <YAxis />
            <Tooltip />
            <Bar dataKey="revenue" />
          </BarChart>
        </ResponsiveContainer>
      </section>

      <section style={sectionStyle}>
        <h2>売上上位商品</h2>
        <table width="100%" border="1" cellPadding="8">
          <thead>
            <tr>
              <th>商品名</th>
              <th>売上</th>
            </tr>
          </thead>
          <tbody>
            {topProducts.map((product) => (
              <tr key={product.product_name}>
                <td>{product.product_name}</td>
                <td>¥{Number(product.revenue).toLocaleString()}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </section>
    </div>
  );
}

const cardStyle = {
  padding: "20px",
  border: "1px solid #ddd",
  borderRadius: "12px",
  width: "220px",
};

const sectionStyle = {
  marginBottom: "40px",
};

export default App;