% This class contains everything related to sensitivity analysis

classdef sensitivities < handle
    % This class contains properties and methods for design field
    
    properties
        dobj_dx         % objective gradient w.r.t densities
        dobj_dVbus      % objective gradient w.r.t Vbus
        dcons_dx        % contraint gradient w.r.t design
        dcons_dVbus     % constraint gradient w.r.t Vbus
    end
    
    methods
        function [dobj_dx, dobj_dsVbus, dcons_dx, dcons_dsVbus] = ...
            compute_sensitivities()
            % computes all the required gradients
            [lambda, status] = obj.sens_analysis_x();
            
            
        end
        
        % Compute the sensitivities w.r.t. densities
        function [lambda, status] = sens_analysis_x(...
                    obj, obj_fem, obj_optim, obj_to)
            lambda = zeros((obj_fem.nely+1)*(obj_fem.nelx+1), 1);
            
            lambda(obj_fem.freedofs) = -obj_fem.K(obj_fem.freedofs, obj_fem.freedofs) \ ...
                (obj_fem.Vbus * sum(obj_fem.dIdv(obj_fem.freedofs, obj_fem.freedofs),1).');
            
            ce = reshape(sum((obj_fem.U_f(obj_fem.edofMat) * obj_fem.KE) .* lambda(obj_fem.edofMat),2), ...
                                                                    obj_fem.nely, obj_fem.nelx);
            c = -obj_fem.Vbus * sum(obj_fem.I_f);
            assert(c == obj_optim.objec, 'Objective value mismatch');

            obj.dbj_dx = obj_to.penal*(obj_to.E0 - obj_to.Emin) * ...
                obj_design.x_phys .^ (obj_to.penal-1).*ce;
  
            dshading = - obj_to.penalS * obj_design.Xs.^(obj_to.penalS-1);
            obj.dobj_dx =  -(obj.dobj_dx + reshape(obj_cell.jL.*diffuse_factor.*dshading.*((-lambda(edofMat))*Qvec),nely,nelx) + Vbus*reshape(jL.*diffuse_factor.*dshading,nely,nelx)*elA);
            
            obj.dcons_dx = ones(obj_fem.nely, obj_fem.nelx);
            status = true;
        end
        
    end
end