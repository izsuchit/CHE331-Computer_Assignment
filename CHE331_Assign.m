
syms Ca 
str=input('GIve an equation in Ca @(Ca): ','s');
rate=str2func(str);
%rate=@(Ca) (k1.*Ca)./(1+k2.*Ca.^2);
rate_dase=diff(rate,Ca);
msg="Choose options";
opts=["Derivative at a point","Area under the curve","Find maximum -ra value corresponding Ca value","Draw a straight line between two point","Find the point where tangent is same as given slope","Function Plot"];
choice=menu(msg,opts);


if choice==1
    P=input("Point of Derivative = ");
    a=vpa(subs(rate_dase,Ca,P));
    fprintf('\nThe Derivative at point %f point=%.8f\n',P,a);

elseif choice==2
    Ca1=input("Enter the value of starting value of Ca (>=0) ");
    Ca2=input("Enter the value of ending value of Ca = ");
    Area=abs(integral(rate,Ca1,Ca2,'ArrayValued',true));  
    fprintf('\nArea under the Curve =%.8f\n',Area);
   

elseif choice==3
    Ca1=input("Enter the value of starting value of Ca(>=0) = ");
    Ca2=input("Enter the value of ending value of Ca = ");
   
    critical_point=solve(rate_dase);
    critical_point=[critical_point;Ca1;Ca2];
    max_value=-inf;
    l=size(critical_point);
    for i=1:l(1)
    t=rate(critical_point(i));
        if t>max_value
           max_value=t;
           point=critical_point(i);
        end 
    end
    h=[];%Range of Ca
   for Ca=Ca1:0.01:Ca2
     h=[h;rate(Ca)];
  end
    Ca=Ca1:0.01:Ca2;
    plot(Ca,h,'b','linewidth',2);
    hold on
    plot(point,max_value,'k*','linewidth',4);
    legend({'-ra','Maxima'})
    title('-ra vs Ca')
    xlabel('Ca')
    ylabel('-ra')
    fprintf('\nMaxima= %.8f at a point %f\n',max_value,point);

elseif choice==4
    
    Ca1=input("Enter the value of starting value of Ca(>=0) = ");
    Ca2=input("Enter the value of ending value of Ca = ");
    x1=input("x coordinate of point 1 = ");
    x2=input("x coordinate of point 2 =");
    y1=rate(x1);
    y2=rate(x2);
    m=(y2-y1)/(x2-x1);
    c=-m*x1+y1;
    y=@(Ca) m.*Ca+c;
    h=[];%Range of Ca
    for Ca=Ca1:0.01:Ca2
        h=[h;rate(Ca)];
    end
    Ca=Ca1:0.01:Ca2;
    plot(Ca,h,'b','linewidth',2);
    hold on
    %Y=str2double(y);
    plot(Ca,y(Ca),'r','LineWidth',2);
    hold on
    grid on
    legend({'-ra','Straight line'})
    xlabel('Ca')
    ylabel('(-ra)')

    title('-ra vs Ca')

    
elseif choice==5
    
    Ca1=input("Enter the value of starting value of Ca(>=0) = ");
    Ca2=input("Enter the value of ending value of Ca = ");
    x1=input("x coordinate of point 1 = ");
    x2=input("x coordinate of point 2 =");
    y1=rate(x1);
    y2=rate(x2);
    m=(y2-y1)/(x2-x1);
    % m=input("Enter slope value: ");

    h=[];%Range of Ca
    for Ca=Ca1:0.01:Ca2
        h=[h;rate(Ca)];
    end
    Ca=Ca1:0.01:Ca2;
    plot(Ca,h,'b','linewidth',2);
    hold on
    res=solve(rate_dase-m);
    len_=size(res);
    pk=[];
    for i=1:len_
        if vpa(res(i))>Ca1 && vpa(res(i))<Ca2
            x_=res(i);
            y_=rate(x_);
            y__=m.*Ca+(y_-m.*x_);
            plot(x_,y_,'m*','linewidth',4);
            pk=[pk;vpa(x_);vpa(y_)];

            plot(Ca,y__,'g','LineWidth',2);
            legend({'-ra','Point','tangent'})
            title('-ra vs Ca')
            xlabel('Ca')
            ylabel('(-ra)')
        end
    end 
    y1=rate(x1);
    y2=rate(x2);
    m=(y2-y1)/(x2-x1);
    c=-m*x1+y1;
    y=@(Ca) m.*Ca+c;
    plot(Ca,y(Ca),'r','LineWidth',2);
    for i=1:2:size(pk)
        fprintf('\nPoint(%.8f,%.8f) at which the slope is same as given slope(%.8f) =\n',pk(i),pk(i+1),m);
    end
elseif choice==6
    Ca1=input("Enter the value of starting value of Ca(>=0) = ");
    Ca2=input("Enter the value of ending value of Ca = ");
    h=[];%Range of Ca
    for Ca=Ca1:0.01:Ca2
        h=[h;rate(Ca)];
    end
    Ca=Ca1:0.01:Ca2;
    plot(Ca,h,'b','linewidth',2);

end
