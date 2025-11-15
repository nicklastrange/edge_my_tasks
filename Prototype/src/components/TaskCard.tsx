import { Clock, AlertCircle } from "lucide-react";
import { useState } from "react";

interface TaskCardProps {
  id: string;
  eventTitle: string;
  categoryName: string;
  status: string;
  deadline: Date;
  actionUrl?: string;
  onPrimaryAction: (id: string) => void;
  onSecondaryAction: (id: string) => void;
}

export function TaskCard({
  id,
  eventTitle,
  categoryName,
  status,
  deadline,
  actionUrl,
  onPrimaryAction,
  onSecondaryAction,
}: TaskCardProps) {
  const [isRemoving, setIsRemoving] = useState(false);
  
  // Calculate hours left
  const now = new Date();
  const hoursLeft = Math.max(0, Math.floor((deadline.getTime() - now.getTime()) / (1000 * 60 * 60)));
  
  const isUrgent = hoursLeft < 5;
  const showCountdown = hoursLeft < 12;

  // Format deadline
  const formatDeadline = (date: Date) => {
    const days = ['ndz', 'pon', 'wt', 'śr', 'czw', 'pt', 'sob'];
    const months = ['sty', 'lut', 'mar', 'kwi', 'maj', 'cze', 'lip', 'sie', 'wrz', 'paź', 'lis', 'gru'];
    return `${days[date.getDay()]}, ${date.getDate()} ${months[date.getMonth()]}`;
  };

  // Category color mapping
  const getCategoryColor = (category: string) => {
    const colors: Record<string, string> = {
      HR: "#F0A020",
      Obowiązkowe: "#1B4E9B",
      Rozrywka: "#10B981",
      Finanse: "#8B5CF6",
    };
    return colors[category] || "#F0A020";
  };

  const categoryColor = getCategoryColor(categoryName);

  const handlePrimaryClick = () => {
    setIsRemoving(true);
    setTimeout(() => {
      onPrimaryAction(id);
    }, 300);
  };

  const getPrimaryActionText = () => {
    if (categoryName === "Finanse") return "Rozliczam";
    if (categoryName === "Rozrywka") return "Zapisuję się";
    return "Wykonuję";
  };

  return (
    <div
      className={`bg-white rounded-2xl p-6 shadow-sm hover:shadow-md transition-all ${
        isRemoving ? "animate-slide-out" : ""
      }`}
    >
      <div className="flex flex-col gap-4">
        {/* Tag Badge */}
        <div className="flex items-center gap-3">
          <span
            className="px-3 py-1 rounded-full text-sm"
            style={{ backgroundColor: `${categoryColor}20`, color: categoryColor }}
          >
            {categoryName}
          </span>
          {showCountdown && (
            <div
              className={`flex items-center gap-1 text-sm ${
                isUrgent ? "text-[#F0A020] animate-pulse-countdown" : "text-[#1B4E9B]"
              }`}
            >
              <Clock className="w-4 h-4" />
              <span>{hoursLeft}h</span>
              {isUrgent && <AlertCircle className="w-4 h-4" />}
            </div>
          )}
        </div>

        {/* Title */}
        <h3 className="text-[#0D1F3A]">{eventTitle}</h3>

        {/* Deadline */}
        <p className="text-sm text-gray-600">
          <span className="text-gray-500">do</span> {formatDeadline(deadline)}
        </p>

        {/* Actions */}
        <div className="flex flex-col sm:flex-row gap-3 mt-2">
          <button
            onClick={handlePrimaryClick}
            className="flex-1 bg-[#1B4E9B] hover:bg-[#163d7a] text-white px-6 py-3 rounded-xl transition-colors"
          >
            {getPrimaryActionText()}
          </button>
          <button
            onClick={() => onSecondaryAction(id)}
            className="flex-1 border-2 border-[#1B4E9B] text-[#1B4E9B] hover:bg-[#1B4E9B] hover:text-white px-6 py-3 rounded-xl transition-colors"
          >
            Odrzucam
          </button>
        </div>
      </div>
    </div>
  );
}