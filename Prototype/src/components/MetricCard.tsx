interface MetricCardProps {
  title: string;
  value: string | number;
  subtitle?: string;
  color?: "blue" | "orange";
  icon?: React.ReactNode;
}

export function MetricCard({ title, value, subtitle, color = "blue", icon }: MetricCardProps) {
  const bgColor = color === "blue" ? "bg-[#1B4E9B]" : "bg-[#F0A020]";
  
  return (
    <div className={`${bgColor} text-white rounded-2xl p-6 shadow-lg hover:shadow-xl transition-all`}>
      <div className="flex items-start justify-between">
        <div>
          <p className="text-sm opacity-90 mb-2">{title}</p>
          <h2 className="text-white">{value}</h2>
          {subtitle && <p className="text-sm opacity-80 mt-2">{subtitle}</p>}
        </div>
        {icon && (
          <div className="opacity-80">
            {icon}
          </div>
        )}
      </div>
    </div>
  );
}
