interface NotificationBadgeProps {
  count: number;
}

export function NotificationBadge({ count }: NotificationBadgeProps) {
  if (count === 0) return null;
  
  return (
    <div className="relative">
      <div className="absolute -top-1 -right-1 bg-[#F0A020] text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">
        {count > 9 ? "9+" : count}
      </div>
    </div>
  );
}
